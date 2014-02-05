
# -*- coding: utf-8 -*-

import os
import sys
import json
import urllib2
import hashlib
import logging

import networkx as nx
import community
import datetime
import pymongo

import facebook
from FQL import FQL


from datetime import datetime
from datetime import timedelta

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
			if elem in ('comments','likes') and data[elem].has_key('count'):
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

	



def get_likes_comments(source,type):
	return get_connections(stored_access_token,type,source)



def get_connections(access_token,type,source="me"):

	graph = facebook.GraphAPI(access_token)
	
	pages=[]	

	logging.info("START get_connections - %s %s" % (source,type))		

	query = graph.get_connections(source,type)
	
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
				logging.warn('HTTPError reading %s - %s' % (url, e))
				if cnt>5:
					query={'data': []}
					rep=True
				pass

	logging.info("DONE - get_connections - %s %s" % (source,type))
	return pages



#def get_mutual_friends(u1id,u2id, access_token):
def get_mutual_friends(u2id, access_token):


	#url="https://graph.facebook.com/%s/mutualfriends/%s?access_token=%s" % (u1id, u2id, access_token)

	url="https://graph.facebook.com/me/mutualfriends/%s?access_token=%s" % (u2id, access_token)


	rep=None	

	while rep==None:
		try:
			req = urllib2.Request(url)
			rep = json.loads(urllib2.urlopen(req).read())
		except (urllib2.HTTPError, urllib2.URLError) as e:
			logging.warn('get_mutual_friends: %s ' % e)
			pass


    	return rep 
	


def get_friends(graph, names=False):
	
	logging.info('get_friends')

	friends=[]	

	friends_query = graph.get_connections('me','friends')
	
	while len(friends_query['data'])>0 and friends_query.has_key('paging'):

		for f in friends_query['data']:
			if names:
				friends.append((f['id'],f['name']))
			else:
				friends.append(f['id'])

		error=True
		url = friends_query['paging']['next']
		while error:
			try:
				req = urllib2.Request(url)			
				friends_query = json.loads(urllib2.urlopen(req).read())
				error=False
			except (urllib2.HTTPError, urllib2.URLError) as e:
				logging.warn('HTTPError in get_friends %s - %s' % (url,e))
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

	communities  = community.best_partition(UG)
	#print communities

	
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



def friend_walk(data,cnt=0, ids=set()):
    if cnt==0:
        ids=set()

    for elem in data:
        if isinstance(elem, (list,dict)):
           friend_walk(elem,cnt+1,ids)
        else:
            if isinstance(data,dict):
                if isinstance(data[elem], (list,dict)):
                        friend_walk(data[elem],cnt+1,ids)
                if elem=='id' and 'name' in data:
                    ids.add(unicode(data[elem]))
            else:
                return

    if cnt==0:
            return ids




def get_connections_by_date(access_token,type,start_date,friends=[],source="me", last=4):

	graph = facebook.GraphAPI(access_token)

	friends = set(friends)
	
	interactions=[]	


	date_format = "%Y-%m-%dT%H:%M:%S+%f"

	#logging.info("START get_connections - %s %s" % (source,type))		

	query = graph.get_connections(source,type)

	try:
		first_item_date = datetime.strptime(query['data'][0]['created_time'], date_format)
		last_item_date = datetime.strptime(query['data'][-1]['created_time'], date_format)
	except:
		first_item_date = datetime.strptime(query['data'][0]['updated_time'], date_format)
		last_item_date = datetime.strptime(query['data'][-1]['updated_time'], date_format)


	#print first_item_date, last_item_date, start_date, first_item_date > start_date, last_item_date > start_date
	

	while len(query['data'])>0 and first_item_date > start_date:

		for data in query['data']:
			item_time=start_date - timedelta(days=100)
			if data.has_key('updated_time'):
				item_time=datetime.strptime(data['updated_time'],date_format)
			elif data.has_key('created_time'):
				item_time=datetime.strptime(data['created_time'],date_format)

			if item_time < start_date or len(set(interactions))>last:
				first_item_date = start_date - timedelta(weeks=1000)
				break
			else:
				#print data
				#print expand(data)
				ids_in_post=friend_walk(data)
				#print "F i P", ids_in_post
				friends_in_post = set(ids_in_post).intersection(friends)
				#print friends_in_post
				interactions = interactions + list(friends_in_post)
		

		if last_item_date > start_date:
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
					#logging.warn('HTTPError reading %s - %s' % (url, e))
					if cnt>5:
						query={'data': []}
						rep=True
					pass
		else:
			query={'data': []}
			

	#logging.info("DONE - get_connections - %s %s" % (source,type))

	
	# interaction minimum?
	interaction_min=1
	pids = {}
	for ppt in interactions:
		pids[ppt]=pids.setdefault(ppt,0)+1

	plist = []
	for ppt in pids:
		if pids[ppt]>=interaction_min:
			plist.append(ppt)

	print type, pids
	#return list(set(interactions))
	return plist



def get_interactions_from_last(access_code, start_point):
	
	stored_access_token = access_code

	graph = facebook.GraphAPI(access_code)

	friend_list = get_friends(graph,names=True)
	friends = set([f[0] for f in friend_list])

	friend_dict=dict(friend_list)
	#print friends, friend_list

	interactions = []

	for uobject in (['feed','inbox']):
		interactions.extend(get_connections_by_date(access_code, uobject, start_point, friends=friends))


	interaction_list = set(interactions)
	
	FB_f = dict(zip(interaction_list,['facebook_f%i' % i for i in range(1,len(interaction_list)+1)]))

	# get FOF data for friend list
	fof_links = fof_interaction(interaction_list, access_code)
	new_links=[]
	for link in fof_links:
		new_links.append((FB_f[link[0]],FB_f[link[1]]))

	#print new_links

	return {'friends':[(FB_f[n], shorten_name(friend_dict[n]), hash(n)) for n in interaction_list],
			'fb_fof': new_links
			}


def shorten_name(name):
	parts = name.split()
	new_name=name
	if len(parts)>1:
		new_name = "%s %s" % (parts[0]," ".join([("%s. " % p[0]) for p in parts[1:]]))

	return new_name

def fof_interaction(friends, access_token):
	'''
		friends is a list of uids
	'''
	fof_links = []
	
	
	for fcnt,f1 in enumerate(friends):
		print fcnt,f1
		
		#u1 = hashlib.md5(key+f).hexdigest()
		#UG.add_node(u1)
		
		mf=get_mutual_friends(f1,access_token)['data']
		for m in mf:
			#print f, m['id']
			#u2 = hashlib.md5(key+m['id']).hexdigest()

			f2=m['id']
			if f2 in friends:
				fof_links.append(tuple(sorted([f1,f2])))
			
	return set(fof_links)


def get_user_objects(uid):

	# get user access_code
	stored_access_token = open('data/%s/%s.access_token' % (uid,uid)).read().strip()

	fql = FQL(stored_access_token)

	fids=[str(f['id']) for f in get_connections(stored_access_token,'friends')]
	
	#fids,friends_network = build_friends_network(uid, stored_access_token)
        #doc = { "uid": uid, "type": "friends_network", "data": friends_network, "timestamp": datetime.datetime.now() }
	#db[uid].insert(doc)


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
			'notes', 'photos', 'albums', 'videos', 'events',
			'groups']


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
						logging.warn("Error getting friends in %s %s" % (uobject, gid))
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
	uid=uid.split('/')[-1].replace('.id','')

	data_dir = 'data/%s' % uid

	stored_access_token=None
	

	# set up logging
	logging.basicConfig(filename="%s/log" % data_dir, level=logging.DEBUG, format='%(asctime)s	%(levelname)s:%(message)s')

	logging.info('-------------------------------  NEW RUN  -------------------------------')


	try:
		stored_access_token = open('%s/%s.access_token' % (data_dir,uid)).read().strip()
	except:
		logging.warning('problem reading access token for UID: %u' % uid)
		sys.exit()

	try:
		db=pymongo.Connection()['fisland']
		logging.info('pymongo connection %s' % db)
	except:
		logging.warning('problem getting pymongo connection')
		sys.exit()

	logging.info('STARTING get_user_objects')
	get_user_objects(uid)
	logging.info('FINISHED get_user_objects')
