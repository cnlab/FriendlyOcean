import pymongo
import json
import networkx as nx
from networkx.readwrite import json_graph
import csv


def calculate_stats(network):
	
	print '\nProcessing', network, '....'	

	try:
		gdata = db[network].find({'type':'friends_network'}).next()['data']
		G = json_graph.node_link_graph(json.loads(gdata))
		ego_degree = len(G.nodes())
		G2 = G.copy()
		for n in G.nodes():
			G2.add_edge('EGO',n)

		ego_betweenness = nx.betweenness_centrality(G2)['EGO']

		print ego_degree, ego_betweenness
		
		db.netstats.insert({'pID': network, '_id': network,
				 'ego_degree': ego_degree, 
     				 'ego_betweenness': ego_betweenness })

		print 'inserted'
		print [i['pID'] for i in db.netstats.find()]

	except:
		print 'ERROR'


def write_csv():

	data = list(db.netstats.find())

	fieldnames = ['_id', 'pID', 'ego_degree', 'ego_betweenness' ]

	with open('darpa_net.csv', 'w') as of:
		out = csv.DictWriter(of, fieldnames=fieldnames)
		out.writerow(dict(zip(fieldnames, fieldnames)))
		out.writerows(data)


if __name__ == "__main__":
	
	db = pymongo.Connection()['darpa']

	networks = [n for n in db.collection_names() if n.startswith('DP')]

	has_stats = [n['pID'] for n in db.netstats.find() if n['pID'].startswith('DP')]


	to_process = set(networks) - set(has_stats)
	print "Networks in DB:" , networks
	print "Existing stats:", has_stats
	print "New to process", to_process

	for net in list(to_process):
		calculate_stats(net)


