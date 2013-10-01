import shutil, subprocess, json, sys, os, time, urllib, csv, tempfile, itertools
import datetime
from datetime import date

import bottle 
from bottle import get, post, response, request, run, route, template, static_file, redirect, SimpleTemplate
from cork import Cork
from beaker.middleware import SessionMiddleware
from cork.backends import MongoDBBackend
import logging

import tps
try:
    from config import config
except:
    from default_config import config

logging.basicConfig(format='localhost - - [%(asctime)s] %(message)s', level=logging.DEBUG)
log = logging.getLogger(__name__)
bottle.debug(True)

session_opts = {
    'session.type': 'cookie',
    'session.validate_key': True,
    'session.cookie_expires': True,
    'session.timeout': 3600 * 24,  # 1 day
    'session.encrypt_key': 'secret',
    'session.auto': True
}

backend = MongoDBBackend(db_name='friendly', initialize=False)

#application = bottle.default_app()
#application = SessionMiddleware(application, session_opts)

app = bottle.app()
app = SessionMiddleware(app, session_opts)
aaa = Cork(backend=backend)

def postd():
    return bottle.request.forms

def post_get(name, default=''):
    return bottle.request.POST.get(name, default).strip()

@route('/configure')
@route('/configure/')
def configure():
    return template('config.tpl')

@route('/get_config')
@route('/get_config/')
def get_config():
    for slide in config['categories']:
        config['categories'][slide]['help'] = "||".join(config['categories'][slide]['help'])
    for slide in config['components']:
        config['components'][slide]['help'] = "||".join(config['components'][slide]['help'])
    return config

@route("/load_config")
def load_config():
    appID = request.query.appID
    return config

@post('/configure')
@post('/configure/')
def do_config():

    d = postd().dict
    print json.dumps(d, indent=2)
    upload = request.files.get('surveys')
    response.status = 200

@route('/surveys_example.json')
def get_survey_example():
    f = json.loads(open("assets/friendly/surveys_example.json", "rU").read())
    return static_file("surveys_example.json", root="./assets/friendly")

@post('/get_interactions')
def get_interaction():
    access_token = post_get('access_token')
    tps.stored_access_token = access_token
    
    week = datetime.timedelta(weeks=1)
    start_date = datetime.datetime.today() - week
    response = {}
    
    try:
        friends = tps.get_interactions_from_last(access_token, start_date)
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

    if request.query.pID:
        pID = request.query.pID
    else:
        pID = "anon"

    if request.query.theme:
        themes = ["ocean", "island", "space"]
        if request.query.theme in themes:
            config['theme'] = request.query.theme

    return template('index', pID=pID, config=config)
    
@route('/assets/<file_path:path>')
def static(file_path):
    return static_file(file_path, root="assets/")
	
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


def check_unique(fname,suffix=1):
    fname_new=fname
    while (os.path.exists('logs/%s.json' % fname_new)):
        fname_new = '%s_%i' % (fname,suffix)
        suffix+=1
    return fname_new
	
# #  Web application main  # #

def main():

    # Start the Bottle webapp
    bottle.debug(True)
    bottle.run(app=app, quiet=False, reloader=True)

if __name__ == "__main__":
    main()
