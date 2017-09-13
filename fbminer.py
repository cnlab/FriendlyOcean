
# -*- coding: utf-8 -*-

import os
import sys
import json
import urllib2
import hashlib
import logging

import networkx as nx
import community as community    # new version of NetworkX changed weighted to weight on graph.size()
import datetime
import pymongo

import facebook
from FQL import FQL

key = "t!p@s#"

def hash(txt):
	hstr = str(txt)

	hashed=hashlib.md5(key+hstr).hexdigest()
	return hashed	



def expand(data):
	for elem in data:
		if isinstance(elem,(list,dict)):
			expand(elem)
		else:
			if elem == 'likes' and isinstance(data[elem],int):
				data[elem] = get_likes_comments(data['id'],elem)
			elif elem in ('comments','likes') and data[elem].has_key('count'):
				cnt = data[elem]['count']
				if data[elem].has_key('data') and len(data[elem]['data']) < cnt:
					data[elem]['data'] = get_likes_comments(data['id'],elem)
			elif isinstance(data,dict):
				if isinstance(data[elem],(dict,list)):
					expand(data[elem])
			else:
				pass

def walk(data):
	for elem in data:
		if isinstance(elem, (list, dict)):
			walk(elem)
		else:
			# process element
			if isinstance(data, dict):
				# elem is a key
				if isinstance(data[elem], (dict,list)):
					walk(data[elem])	
				elif elem == 'name':
					data[elem]=''
				elif elem == 'uid' or elem == 'id':
					data[elem]=hash(data[elem])		

				elif elem == 'story' and data.has_key('story_tags'):
					story=data['story']
					for tag in data['story_tags']:
						for i,u in enumerate(data['story_tags'][tag]):
							if u.has_key('offset'):
								offset=u['offset']
								length=u['length']
								story=story[0:offset]+'X'*length+story[offset+length:]
						data['story'] = story

			else:
				pass			



def friend_walk(data,cnt=0, ids=set()):
    if cnt==0:
	if ids.__class__ == list:
		ids=[]
	else:
	        ids=set()

    for elem in data:
        if isinstance(elem, (list,dict)):
           friend_walk(elem,cnt+1,ids)
        else:
            if isinstance(data,dict):
                if isinstance(data[elem], (list,dict)):
                        friend_walk(data[elem],cnt+1,ids)
                if elem=='id' and 'name' in data:
		    if ids.__class__ == list:
			ids.append(unicode(data[elem]))
		    else:
                    	ids.add(unicode(data[elem]))
            else:
                return

    if cnt==0:
            return ids	



def get_likes_comments(source,type):
	return get_connections(stored_access_token,type,source)




def get_connections(access_token,type,source="me"):

	graph = facebook.GraphAPI(access_token)
	
	pages=[]	

	logging.info("START get_connections - %s %s" % (source,type))		

	try:
		query = graph.get_connections(source,type)
	except:
		logging.warning('ERROR getting connections for %s - %s' % (source,type))
		return pages	



	while len(query['data'])>0 and query.has_key('paging'):
		for data in query['data']:
			pages.append(data)
		
		cnt=0
		rep=None
		while rep==None:
			try:
				url = query['paging']['next']
				req = urllib2.Request(url)
				rep = urllib2.urlopen(req).read()
				query = json.loads(rep)
			except (urllib2.HTTPError, urllib2.URLError) as e:
				cnt+=1
				logging.warning('HTTPError reading %s - %s' % (url, e))
				if cnt>5:
					query={'data': []}
					rep=True
				#pass
			except:
				print "ERROR - ", pages
				rep=True
				query={'data': []}
				#pass

	logging.info("DONE - get_connections - %s %s" % (source,type))
	return pages



def get_mutual_friends(u1id,u2id, access_token):

	url="https://graph.facebook.com/%s/mutualfriends/%s?access_token=%s" % (u1id, u2id, access_token)

	rep=None	

	while rep==None:
		try:
			req = urllib2.Request(url)
			rep = json.loads(urllib2.urlopen(req).read())
		except (urllib2.HTTPError, urllib2.URLError) as e:
			logging.warning('get_mutual_friends: %s ' % e)
			pass


    	return rep 
	


def get_friends(graph):
	
	logging.info('get_friends')

	friends=[]	

	friends_query = graph.get_connections('me','friends')
	
	while len(friends_query['data'])>0 and friends_query.has_key('paging'):

		for f in friends_query['data']:
			friends.append(f['id'])

		error=True
		url = friends_query['paging']['next']
		while error:
			try:
				req = urllib2.Request(url)			
				friends_query = json.loads(urllib2.urlopen(req).read())
				error=False
			except (urllib2.HTTPError, urllib2.URLError) as e:
				logging.warning('HTTPError in get_friends %s - %s' % (url,e))
				pass

	return friends
		



def build_friends_network(uid,access_token):

	logging.info('START building friends network')

	# check if path exists
	path = os.path.join('data',uid)

	graph = facebook.GraphAPI(access_token)


	me = graph.get_object('me')['id']

	friends = get_friends(graph)

	fids = [str(f) for f in friends]

	logging.info("User has %i friends" % len(friends))

	UG=nx.Graph()

	for fcnt,f in enumerate(friends):
		#print "looking for mutual friends with", f
		if fcnt % 50 == 0:
			logging.info('processed %i of %i friends' % (fcnt, len(friends)))
		u1 = hashlib.md5(key+f).hexdigest()
		UG.add_node(u1)
		mf=get_mutual_friends(me,f,access_token)['data']
		for m in mf:
			#print f, m['id']
			u2 = hashlib.md5(key+m['id']).hexdigest()

			UG.add_edge(u1,u2)

	#print UG.nodes()


	# write graphml
	nx.write_graphml(UG, os.path.join(path,'%s_network.graphml' % uid))

	try:
		communities  = community.best_partition(UG)
	except:
		communities = dict(map(lambda x: (x,0),UG.nodes()))
	
	logging.info("creating JSON for friends network...")


	graph_json = { "nodes": [], "links": [] }

	node_dict = dict(zip([n for n in UG.nodes()], range(0,len(UG.nodes()))))	

	for n in UG.nodes():
		graph_json['nodes'].append({"name": n, "group": communities[n]})

	for e in UG.edges():
		n_from=node_dict[e[0]]
		n_to=node_dict[e[1]]
		graph_json['links'].append({"source": n_from, "target": n_to, "value": 1})


	return fids,json.dumps(graph_json)






def get_user_objects(uid):

	# get user access_code
	stored_access_token = open('data/%s/%s.access_token' % (uid,uid)).read().strip()

	fql = FQL(stored_access_token)

	#fids=[str(f['id']) for f in get_connections(stored_access_token,'friends')]
	
	fids,friends_network = build_friends_network(uid, stored_access_token)
        doc = { "uid": uid, "type": "friends_network", "data": friends_network, "timestamp": datetime.datetime.now() }
	db[uid].insert(doc)


	# get user details
	#
	
	logging.info('START getting user details')
	query = '''SELECT affiliations, sex, timezone, languages, timezone, birthday, hometown_location, 
		          current_location, friend_count, likes_count, sports, education, locale, wall_count, notes_count 
		   FROM user WHERE uid = %s'''

	 
	logging.info('getting app user data')
	user_data=[]
	user_id=fql.query('SELECT uid FROM user WHERE uid=me()')[0]['uid']
	data = fql.query(query % user_id)
	user_data.append({'id': hash(str(user_id)), "data": data})
	doc = {"uid": uid, "type": "user_data", "data": user_data, "timestamp": datetime.datetime.now() }
	db[uid].insert(doc)
	logging.info('got app user data')


	friend_data=[]

	for ucnt,friend_id in enumerate(fids):
		try:
			data=fql.query(query % friend_id)
		except:
			pass
		friend_data.append({'id': hash(friend_id) , 'data': data})
	
		if ucnt % 50 == 0:
			logging.info('got details from %i of %i friends' % (ucnt,len(fids)))

	doc = { "uid": uid, "type": "friends_data", "data": friend_data, "timestamp": datetime.datetime.now() }
	db[uid].insert(doc)

	logging.info('DONE getting user details')

	

	user_objects = ['home', 'feed', 'likes', 'movies', 'music', 'books', 
			'notes', 'photos', 
			#'albums', 
			'videos', 'events',
			'groups', 'inbox', 'outbox']


	for uobject in user_objects:
		logging.info("Getting object: %s" % uobject)

		data = get_connections(stored_access_token, uobject)

		logging.info("%s JSON collected" % uobject)

		if uobject in ('groups', 'events'):
			for cnt,item in enumerate(data):
				gid=item['id']
				logging.info('Getting friends for %s %s' % (uobject,gid))
				
				if uobject == 'groups':
					query = 'SELECT uid FROM group_member WHERE gid="%s" AND uid in (%s)' % (gid, ','.join(fids))
				elif uobject == 'events':
					query = 'SELECT uid,rsvp_status FROM event_member WHERE eid="%s" AND uid in (%s)' % (gid, ','.join(fids))
	
				uids=0
				while not isinstance(uids, list):
					try:
						uids = fql.query(query)
					except:
						logging.warning("Error getting friends in %s %s" % (uobject, gid))
						uids+=1
						if uids>5:
							uids=[]
						pass

				item['friends'] = uids			
				logging.info('Got %i friends for %s %s' % (len(uids),uobject,gid))

	

		# ANONYMIZE DATA 

		if uobject != 'home':
			expand(data)
		walk(data)
		anon_data = data
		

		doc = { "user_id": uid, "type": uobject, "data": anon_data, "timestamp": datetime.datetime.now() }

		db[uid].insert(doc)

		logging.info("Inserted %s JSON into database" % uobject)

	



if __name__ == "__main__":


	uid = sys.argv[1]

	print "**** ", uid	

	if not uid.endswith('.access_token'):
		sys.exit('ERROR with ' + uid)

	if not os.path.exists(os.path.join('data',uid.split('/')[-2])):
		sys.exit('ERROR directory or token doesn\'t exist -> ' + uid)

	uid=uid.split('/')[-1].replace('.uid','').replace('.access_token','')

	data_dir = 'data/%s' % uid

	# set up logging
	logging.basicConfig(filename="%s/log" % data_dir, level=logging.DEBUG, format='%(asctime)s	%(levelname)s:%(message)s')

	logging.info('-------------------------------  NEW RUN  -------------------------------')


	try:
		stored_access_token = open('%s/%s.access_token' % (data_dir,uid)).read().strip()
	except:
		logging.warning('problem reading access token for UID: %u' % uid)
		sys.exit()

	try:
		db=pymongo.Connection()['darpa']
		logging.info('pymongo connection %s' % db)
	except:
		logging.warning('problem getting pymongo connection')
		sys.exit()

	logging.info('STARTING get_user_objects')
	get_user_objects(uid)
	logging.info('FINISHED get_user_objects')
