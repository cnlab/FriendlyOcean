import os, sys

#Uncomment for deployment using mod_wsgi or Passenger
#os.chdir(os.path.dirname(__file__))
#sys.path.append('.')

import shutil, subprocess, json, time, urllib, csv, tempfile, itertools, hashlib, zipfile
import cgi
import datetime
from datetime import date
from base64 import b64decode, b64encode

import bottle 
from bottle import get, post, response, request, run, route, template, static_file, redirect, SimpleTemplate
from cork import Cork
from beaker.middleware import SessionMiddleware
from cork.backends import MongoDBBackend
import logging

import tps
from default_config import config as def_config

logging.basicConfig(format='localhost - - [%(asctime)s] %(message)s', level=logging.DEBUG)
log = logging.getLogger(__name__)
bottle.debug(False)

arrows = {"ocean": "turtle", "island": "coconut", "space": "asteroid"}

session_opts = {
    'session.type': 'cookie',
    'session.validate_key': True,
    'session.cookie_expires': True,
    'session.timeout': 3600 * 24,  # 1 day
    'session.encrypt_key': 'couchhorse',
    'session.auto': True
}

try:
    backend = MongoDBBackend(db_name='friendly', initialize=False)
except:
    backend = None

aaa = Cork(backend=backend)

application = bottle.default_app()
application = SessionMiddleware(application, session_opts)

def postd():
    return bottle.request.forms

def post_get(name, default=''):
    return bottle.request.POST.get(name, default).strip()

def sesh_redir(msg="Please log in to continue."):
    """
    Helper function for setting redirect in the session.
    """
    sess = request.environ.get("beaker.session")
    sess['redir'] = request.path.lstrip("/")
    sess['redir_msg'] = msg
    return sess

@route("/my-data")
def show_logs():
    if aaa.user_is_anonymous:
        sesh_redir()
        bottle.redirect("/login")

    user = aaa.current_user
    apps = {}

    if request.query.filter:
        app_list = [ app.strip() for app in request.query.filter.split(",") ]
    else:
        app_list = user.apps.split(',')

    if len(app_list) > 0:
        for appID in app_list:
            apps[appID] = [ log for log in os.listdir("logs") if log.startswith(appID) and log.endswith(".json") ]
            aaa.sort_nicely(apps[appID])
    return template("my_data", apps=apps, user=user)


@route('/logout')
def logout():
    aaa.logout(success_redirect='/login')

@route("/login")
def login():
    if not aaa.user_is_anonymous:
        bottle.redirect("/profile")
    auth = request.query.auth
    sess = request.environ.get("beaker.session")
    if sess.has_key("redir_msg"):
        msg = sess['redir_msg']
        return template("login", error=msg)
    else:
        return template("login")

@post("/login")
def do_login():
    auth = request.query.auth
    sess = request.environ.get("beaker.session")
    d = postd().dict

    if sess.has_key("redir"):
        success_redirect = sess['redir']
        fail_redirect = "/login"
    else:
        success_redirect = "/profile"
        fail_redirect = "/login"
    aaa.login(d["username"][0], d["password"][0], success_redirect=success_redirect, fail_redirect=fail_redirect)

@route("/profile")
def show_profile():

    if aaa.user_is_anonymous:
        sesh_redir()
        bottle.redirect("/login")

    return template("profile", user=aaa.current_user, apps=aaa.list_apps(user=aaa.current_user))

@route("/admin")
def show_admin():
    if aaa.user_is_anonymous:
        sesh_redir()
        bottle.redirect("/login")
    aaa.require(role="admin", fail_redirect="/profile")
    users = aaa.list_users()
    apps = aaa.list_apps()
    data = aaa.list_data()
    return template("admin", user=aaa.current_user, apps=apps, users=users, data=data)
   
@post("/delete_app")
def delete_app():

    if aaa.user_is_anonymous:
        sesh_redir()
        bottle.redirect("/login")

    appID = post_get('appID')
    msg = {}
    if appID is not "":
        try:
            aaa.delete_app(appID)
            msg['text'] = "App %s has been deleted" % appID
            msg['type'] = "success"
        except:
            msg['text'] = "Sorry, app %s could not be deleted." % appID
            msg['type'] = "error"
    else:
        msg['text'] = "Invalid app ID."
        msg['type'] = "error"

    return template("profile_apps_table", apps=aaa.list_apps(user=aaa.current_user), msg=msg)

@post("/validate")
def validate():
    username = post_get('username')
    appID = post_get('appID')
    if username is not "":
        if aaa.user(username):
            return "false"
        return "true"
    if appID is not "":
        if not aaa.check_apps_for(appID):
            response.status = 500
            return "That appID already exists."
        if len( appID.split() ) > 1:
            response.status = 500
            return "Please remove any spaces from the app ID."

@route("/register")
def register():
    if not aaa.user_is_anonymous:
        bottle.redirect("/profile")
    return template("register")

@post("/register")
def do_register():
    d = postd().dict
    if len(d["organization"][0]) > 0:
        org = d["organization"][0]
    else:
        org = ""
    try:
        aaa.register(d["username"][0], d["first_name"][0], d["last_name"][0], d["password"][0], d["email_addr"][0], org)
    except:
        response.status = 500
        return "Sorry, there was an error during registration. Please contact communication.neuroscience@gmail.com or try again later."
    
    aaa.login(d["username"][0], d["password"][0], success_redirect="/profile")

@route("/load_config")
def load_config():
    appID = request.query.appID
    try:
        config = aaa.load_app(appID)
    except:
        config = def_config
    return config

@route('/configure')
def configure():
    if aaa.user_is_anonymous:
        sesh_redir()
        bottle.redirect("/login")
    categories = [ (cat["id"], cat["title"]) for cat in def_config["categories"] ]
    components = [ (cat["id"], cat["title"]) for cat in def_config["components"] ]
    components.insert(2, ("survey", "Survey"))
    return template('config.tpl', user=aaa.current_user, categories=categories, components=components)

@post('/configure')
def do_config():

    if aaa.user_is_anonymous:
        sesh_redir()
        bottle.redirect("/login")

    #Create config dictionary
    cData = { "created": datetime.datetime.now().strftime("%x") }
    cData["owner"] = aaa.current_user.username
    
    #Create appID, might be overwritten later
    x = hashlib.sha1()
    x.update(datetime.datetime.now().strftime("%c"))
    appID = x.hexdigest()[:10].lower()

    #Make sure appID doesn't exist
    while not aaa.check_apps_for(appID):
        x.update(datetime.datetime.now().strftime("%c"))
        appID = x.hexdigest()[:10].lower()

    #Get data
    d = postd().dict
    upload = request.files.get('file')
    if upload:
        try:
            survey_dict = json.loads(upload.file.read())
        except:
            response.status = 500
            return '<p>There was a problem parsing your JSON file.<p><p>Please make sure you submit a well-formed JSON file. Check out the <a href="assets/friendly/surveys_example.json" target="_blank">example</a> or the <a href="assets/friendly/surveys_template.json" target="_blank">template</a>.'
    
    #####
    #Build config dictionary
    #####

    #Set theme
    cData["theme"] = d["theme"][0]
    cData["arrowType"] = arrows[cData["theme"]]

    #Set max friends or default
    try:
        cData['maxFriendsPerCategory'] = int(d['max'][0])
    except:
        cData['maxFriendsPerCategory'] = 20

    #Set time frame for FB interactions
    try:
        cData['timeFrameNum'] = int(d['timeFrameNum'][0])
        cData['timeFrameType'] = d['timeFrameType'][0]
    except:
        cData['timeFrameNum'] = 1
        cData['timeFrameType'] = "weeks"

    #Set appID
    if len(d['appID'][0]) > 0:
        appID = d['appID'][0].lower()
    cData["appID"] = appID

    #Set description
    cData["description"] = d["description"][0]

    #Set categories or default
    cData["categories"] = []
    if d['categories'][0] is not "":
        cats = d["categories"][0].split(",")
        for cat in cats:
            for each in def_config["categories"]:
                if each["id"] == cat:
                    cData["categories"].append(each)
    else:
        cData["categories"] = def_config["categories"]

    #Set components or default
    if len(d['components'][0]) > 0:
        cData["components"] = []

        comps = d["components"][0].split(",")
        for comp in comps:
            if comp == "survey" and upload:
                cData["components"].append({
                                           "id": comp,
                                           "title": "Describe",
                                           "help": ["Please respond to the following question for each person."],
                                           "surveys": survey_dict["surveys"]
                                           })
            else:
                for each in def_config["components"]:
                    if each["id"] == comp:
                        cData["components"].append(each)
    else:
        cData["components"] = def_config["components"]

    #Save config file
    config_filename = "%s.py" % appID

    try:
        aaa.save_app(cData)
        response.status = 200
    except:
        response.status = 500
        return "<p>We were unable to save your app. Please try again later.</p>"
    return template("config_success", appID=appID)

@post('/get_interactions')
def get_interaction():

    access_token = post_get('access_token')

    APP_ID='333451740118555'
    APP_SECRET='f457263516b17536bca5981730737f1f'


    # get extended time token
    #   https://graph.facebook.com/oauth/access_token?
    #   client_id=APP_ID&
    #   client_secret=APP_SECRET&
    #   grant_type=fb_exchange_token&
    #   fb_exchange_token=EXISTING_ACCESS_TOKEN

    url	= 'https://graph.facebook.com/oauth/access_token?client_id=%s&client_secret=%s&grant_type=fb_exchange_token&fb_exchange_token=%s'

    url	= url %	(APP_ID, APP_SECRET, access_token)

    req=urllib.urlopen(url)
    data = cgi.parse_qs(req.read())

    new_access_token = data['access_token'][-1]

    # store the access token in data folder - this can be made optional
    pid = post_get('pID')
    write_access_token(pid,access_token,'atok_bu')
    write_access_token(pid,new_access_token)

    timeframe_num = int(post_get('timeFrameNum'))
    timeframe_type = post_get('timeFrameType')
    
    
    ordered = post_get('ordered',False)
    
    
    tps.stored_access_token = access_token
    
    if timeframe_type == 'days':
        timeframe = datetime.timedelta(days=timeframe_num)
    else:
        timeframe = datetime.timedelta(weeks=timeframe_num)
    
    start_date = datetime.datetime.today() - timeframe
    response = {}
    
    try:
        friends = tps.get_interactions_from_last(access_token, start_date, ordered=ordered)
        response['response'] = 'true'
        response['fbFriends'] = friends

    except:
        response['response'] = 'false'

    return json.dumps(response)
    
@route('/channel')
def channel():
    return render('<script src="//connect.facebook.net/en_US/all.js"></script>')

@route('/')
def index():

    if request.query.appID:
        appID = request.query.appID
        try:
            config = aaa.load_app(appID.lower())
        except:
            print "Unable to load config for %s" % appID
            config = def_config
    else:
        config = def_config

    if request.query.pID:
        pID = request.query.pID
    else:
        pID = "anon"

    if request.query.theme:
        themes = ["ocean", "island", "space"]
        if request.query.theme in themes:
            config['theme'] = request.query.theme
            config['arrowType'] = arrows[config['theme']]
    
    if os.path.exists('views/index_%s.tpl' % appID):
    		return template('index_%s.tpl' % appID, pID=pID, config=config)
    else:
            return template('index', pID=pID, config=config)
    
@route('/assets/<file_path:path>')
def static(file_path):
    return static_file(file_path, root="assets/")

@post("/view-file")
def view_file():
    if aaa.user_is_anonymous:
        sesh_redir()
        bottle.redirect("/login")
    logs = os.listdir("logs")
    file_name = post_get("file")
    for file in logs:
        if file_name == file:
            file_out = json.loads(open("logs/%s" % file_name, "rU").read())
            file_out = json.dumps(file_out, indent=2)
            return file_out
    return "<p>Sorry, %s not found.</p>" % file_name

@route("/download-data")
def download_data():
    if aaa.user_is_anonymous:
        sesh_redir()
        bottle.redirect("/login")

    user = aaa.current_user
    if request.query.type and request.query.file:
        type = request.query.type
        file = request.query.file
        if type == "all":
            
            if file not in user.apps.split(','):
                return "<p>Sorry, that app belongs to another user.</p>"

            zfn = "%s-data.zip" % file
            zpath = "logs/archives/%s" % zfn
            logs = [ "logs/%s"%log for log in os.listdir("logs") if log.startswith(file) and log.endswith(".json")]
            if len(logs) == 0:
                    return "<p>Sorry, no data files were found.</p>"
            elif not os.path.exists(zpath):
                zf = zipfile.ZipFile(zpath, "w")
                for d in logs:
                    zf.write(d)
                zf.close()
            elif os.path.exists(zpath):
                zf = zipfile.ZipFile(zpath, "a")
                old_logs = zf.namelist()
                new_logs = set(logs).difference(old_logs)
                if len(new_logs) > 0:
                    for d in set(logs).difference(old_logs):
                        zf.write(d)
                zf.close()
            return static_file(zfn, root="logs/archives/", download=True)

        elif type == "one":
            return static_file(file, root="logs/", download=True)

        else:
            response.status = 404
            return
    else:
        response.status = 404
        return

@post('/log')
def write_log():
    try:
        data=json.loads(request.body.read())
        log_file = check_unique("%s_%s" % (data['appID'],data['pID']))
        log = open('logs/%s.json' % log_file, 'w')
        log.write(json.dumps(data))
        log.close()
        request.response = 200
    except:
        request.response = 500


def write_access_token(user_id,access_token,filename=''):

	fn = ('%s.access_token' % user_id) if filename=='' else filename

	if os.path.exists('data/%s' % (user_id)):
	
		if os.path.exists('data/%s/%s' % (user_id,fn)):

			# check if access_tokens are the same
			stored_access_token = open('data/%s/%s' % (user_id,fn)).read().strip()
		else:
			stored_access_token = None		
	
		if not access_token == stored_access_token:
			out = open('data/%s/%s' % (user_id, fn), 'w')
			out.write(access_token)
			out.close()
		

	else:
		os.mkdir('data/%s' % user_id)
		out = open('data/%s/%s' % (user_id, fn), 'w')
		out.write(access_token)
		out.close()



def check_unique(fname,suffix=1):
    fname_new=fname
    while (os.path.exists('logs/%s.json' % fname_new)):
        fname_new = '%s_%i' % (fname,suffix)
        suffix+=1
    return fname_new
	
# #  Web application main  # #

def main():

    # Start the Bottle webapp
    bottle.debug(False)
    bottle.run(app=application, quiet=False, reloader=True)

if __name__ == "__main__":
    main()
