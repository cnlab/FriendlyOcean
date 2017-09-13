import pymongo
import sys
import json

if __name__ == '__main__':
	try:
		appID = sys.argv[1]
	except:
		sys.exit('need appID')


	db = pymongo.Connection()['friendly']

	try:
		config = db.apps.find_one({'appID':appID})
	except:
		sys.exit('Error trying to find app config')


	print(json.dumps(config, indent=4))
