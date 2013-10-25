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

        1) Add my Facebook App ID
        2) Copy my MongoDB to a JSON DB
        3) Copy my JSON DB to a MongoDB
        4) Copy my app from the CNL server to this computer.
        0) Exit
'''

    def Menu(self):
        choice = raw_input("\tType your selection here --> ")
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
        elif choice == '0' or choice == 'quit':
            sys.exit()
        else:
            print '''\tSorry, %s is not an option.\n''' % choice
            self.Menu()

    def ChangeFB(self):
        '''Change the FB app ID'''
        fbapp = raw_input("\n\tPlease enter your Facebook App ID here --> ")
        if fbapp == 'quit':
            print "\tGoodbye!"
            sys.exit()

        #Check to make sure it's a real app.
        print "\n\n\tVerifying app with Facebook...\n"
        try:
            response = json.loads( urllib.urlopen("http://graph.facebook.com/%s" % fbapp).read() )
        except:
            print "\n\tSorry, I could not connect to http://graph.facebook.com/ to verify the id %s\n" % fbapp
            sys.exit()

        if "error" in response:
            print "\n\tSorry, that %s is not a valid Facebook App ID\n" % fbapp
            self.ChangeFB()
        elif response["id"] != fbapp:
            print "\n\tThe response ID did not match the ID you supplied.\n"
            self.ChangeFB()

        f = open("views/index.tpl", "rU")
        data = f.readlines()
        f.close()

        data[31] = re.sub(r'[\'"].*[\'"]',  r"'"+fbapp+r"'", data[31])
        with open("views/index.tpl", "wb") as out:
            out.writelines(data)
        print "\n\tFacebook App succesfully changed!\n"

    def MongoToJson(self):
        '''Backup a MongoDB instance to JSON files'''
        print "Copying from Mongo to JSON isn't working yet."

    def JsonToMongo(self):
        '''Backup a JSON DB to a MongoDB instance'''
        print "Copying from JSON to Mongo isn't working yet."

    def CopyFromCNL(self):
        '''Copy down an app fom the CNL servers'''
        site = "http://127.0.0.1:8080"
        username = raw_input("\n\tPlease enter your username for the Friendly Island site --> ")
        password = getpass.getpass("\n\tPlease enter your password for the Friendly Island site -->")
        app = raw_input("\n\tPlease enter the id of the app you'd like to copy --> ")
        if username == 'quit' or password =='quit' or app == 'quit':
            print "\n\tGoodbye!\n"
            sys.exit()
        print "\n\tConnecting to the CNL server...\n"
        mash = "%s::%s::%s" % (username, password, app)
        response = urllib.urlopen(site+"/load_config?appID=%s" % app).read()
        print response

if __name__ == "__main__":
    util = FIUtil()
    while 1 :
        print util.Menu()