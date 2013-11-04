#!/usr/bin/env python
#
#Utilities for using Friendly Island
#

import sys, os, getpass, urllib, json, re
from base64 import b64encode, b64decode

class FIUtil(object):

    def __init__(self):
        os.system('cls' if os.name=='nt' else 'clear')
        self.PrintMenu()

    def PrintMenu(self):
        print '''
Welcome to the Friendly Island Utility App!
You can type quit at any time to exit this tool.

What would you like to do?

    1) Change the Facebook App ID
    2) Copy my MongoDB to a JSON DB
    3) Copy my JSON DB to a MongoDB
    4) Copy my app from the CNL server to this computer.
    5) Setup a Mongo database
    0) Exit
'''

    def Menu(self):
        choice = raw_input("Type your selection here --> ")
        if choice == '1':
            self.ChangeFB()
            sys.exit()
        elif choice == '2':
            self.MongoToJson()
            sys.exit()
        elif choice == '3':
            self.JsonToMongo()
            sys.exit()
        elif choice == '4':
            self.CopyFromCNL()
            sys.exit()
        elif choice == '5':
            self.SetupMongo()
            sys.exit()
        elif choice == '0' or choice == 'quit':
            sys.exit()
        else:
            print '''Sorry, %s is not an option.''' % choice
            self.Menu()

    def ChangeFB(self):
        '''Change the FB app ID'''
        fbapp = raw_input("Please enter your Facebook App ID here --> ")
        if fbapp == 'quit':
            print "Goodbye!"
            sys.exit()

        print "Verifying app with Facebook..."
        try:
            response = json.loads( urllib.urlopen("http://graph.facebook.com/%s" % fbapp).read() )
        except:
            print "Sorry, I could not connect to http://graph.facebook.com/ to verify the id %s" % fbapp
            sys.exit()

        if "error" in response:
            print "Sorry, that %s is not a valid Facebook App ID" % fbapp
            self.ChangeFB()
        elif response["id"] != fbapp:
            print "The response ID did not match the ID you supplied."
            self.ChangeFB()

        f = open("views/index.tpl", "rU")
        data = f.readlines()
        f.close()

        data[31] = re.sub(r'[\'"].*[\'"]',  r"'"+fbapp+r"'", data[31])
        with open("views/index.tpl", "wb") as out:
            out.writelines(data)
        print "Facebook App succesfully changed!"

    def MongoToJson(self):
        '''Backup a MongoDB instance to JSON files'''
        print "Copying from Mongo to JSON isn't working yet."

    def JsonToMongo(self):
        '''Backup a JSON DB to a MongoDB instance'''
        print "Copying from JSON to Mongo isn't working yet."

    def SetupMongo(self):
        '''Setup and initialize Mongo database'''
        errors = []
        colls = ["apps", "users", "roles"]
        
        try:
            import pymongo
        except:
            print "Unable to import pymongo. You need to install the pymongo package before continuing."
            sys.exit()

        print "Connecting to the local mongo service..."
        
        try:
            client = pymongo.MongoClient()
        except:
            print "Unable to connect to the mongod instance at localhost:27017. Is the service running?"
            sys.exit()

        if "friendly" not in client.database_names():
            print "Database 'friendly' not found, creating it now..."
            db = client.friendly

            for coll in colls:
                print "Creating the %s collection..." % coll
                try:
                    db.create_collection(coll)
                    if coll == "roles":
                        print "Creating default roles..."
                        db.roles.insert([
                                {"role": "admin", "val":100},
                                {"role": "user", "val":50}
                                ])
                except:
                    print "Unable to create the '%s' collection." % coll
                    errors.append("The '%s' collection was not created" % coll)

            if len(errors) > 0:
                print "Process completed with %d error(s):" % len(errors)
                for err in errors:
                    print err
            else:
                print "Process complete."

        else:
            print "Found 'friendly' database. Validating setup..."
            db = client.friendly




    def CopyFromCNL(self):
        '''Copy down an app fom the CNL servers'''
        site = "http://127.0.0.1:8080"
        username = raw_input("Please enter your username for the Friendly Island site --> ")
        password = getpass.getpass("Please enter your password for the Friendly Island site -->")
        app = raw_input("Please enter the id of the app you'd like to copy --> ")
        if username == 'quit' or password =='quit' or app == 'quit':
            print "Goodbye!"
            sys.exit()
        print "Connecting to the CNL server..."
        mash = "%s::%s::%s" % (username, password, app)
        response = urllib.urlopen(site+"/load_config?appID=%s" % app).read()
        print response

if __name__ == "__main__":
    util = FIUtil()
    while 1 :
        print util.Menu()