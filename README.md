# Friendly Island

An application for the analysis of online and offline social interactions.

Created by the [Communication Neuroscience Lab, University of Pennsylvania](http://cn.asc.upenn.edu/)

## Requirements

#### OS

Friendly Island has been tested succesfully on the following operating systems. However it is possible that other systems will work fine, too:

* OS X 10.6+
* Ubuntu 12.04
* RedHat 6
* Windows 7

#### Languages
* Python 2.7
    * __Required Non-Standard Modules__
        * networkx
        * pycryptopp
        * pymongo

#### Databases
* MongoDB (optional)

## Installation

Friendly Island can be installed and run quickly. It is designed to work either on a server (using mod_wsgi or Passenger, for example) or on a local machine. There are some choices that must be made beforehand, though, that will dictate your installation.

#### Step 1: Get it.

Download and extract [FriendlyIsland.zip](#). This file contains all of the files needed for the Friendly Island application.

#### Step 2: Choose a database backend.

Friendly Island is designed to work with either MongoDB or a simple JSON file backend. There are advantages and disadvantages to both. It can even work with both *at the same time*, falling back on local JSON files if the Mongo service isn't running.

##### Choice A -- MongoDB

When Friendly Island starts up, it will first look for a MongoDB instance running on your machine at `localhost`  port `27017`. These are generally the default settings for `mongod`. If a service is found, Friendly Island will expect the following:

* *Database Name:* `friendly`
* *Collections:*
    * `users`
    * `roles`
    * `apps`

The `users` and `apps` collections can be empty, but the `roles` collection needs to have the following records:
    
    {"role": "admin", "val": 100}
    {"role": "user" ,"val": 50}

If you're working in the `mongo` shell (meaning that you opened a command-line program for your system and you typed `mongo`), you can type the following commands to fill the `roles` collection:
    
    use friendly
    db.roles.insert({"role": "admin", "val": 100})
    db.roles.insert({"role": "user" ,"val": 50})
    quit()

After populating the `roles` collection, you should be good to go.

##### Choice B -- JSON

The JSON files are located in the `conf/` folder a the root of the app. You will find three files in this folder:

* users.json
* roles.json
* apps.json

`users.json` and `apps.json` will be empty objects, *not empty files*. if you open one of them you'll find the following line of code:

    {}

Do not remove these empty brackets. Even though they're empty, it's a valid JSON file, which is what the app looks for.

`roles.json` is prepopulated with the required information, so you have no need to worry about it. If your curious, it looks like this:

    {
        "admin": 100,
        "user": 50
    }

##### Which backend should you choose?

For the most portable setup, don't even bother setting up a MongoDB instance. The app will look for one by default but then fallback to the JSON files when one isn't found. This means that you can keep all of your information in one folder and just move that folder around as you see fit. However, this is also a risky move as those three little JSON files contain *all the information for your version of Friendly Island: users, apps--everything*. It is strongly encouraged that if you choose this method, you regularly backup the `conf/` folder. This method is fine if you know that only one participant will be going through the app at a time.

If you're going to host your own version of Friendly Island on your own server or on a local machine, and you can have a MongoDB install, this is the safest route to take. This gives you safeguards like simultaneous write protection and the such.

We have included a script called `FI_Utilities.py` which will setup the friendly database, among other things, for you and populate it with the required collections and records. Just run

    python FI_Utilities.py

from the command line to get started.


#### Step 3: Change the Facebook App ID

Friendly Island makes use of the Facebook API to gather data about participants recent interactions on Facebook.

#### Step 4: Run it.

Once you've got everything set up, you're ready to run the app. If you've deployed it to a server (i.e. Apache), it's up to you to determine the best way to configure it based on the modules you're using.

If you're running it on a local machine, open a command-line program, navigate to the folder where you extracted the [FriendlyIsland.zip](#) file to and run the following command:

    python app.wsgi

If all goes well, you should see the following output:

    Bottle v0.12-dev server starting up (using WSGIRefServer())...
    Listening on http://127.0.0.1:8080/
    Hit Ctrl-C to quit.


Open a browser and navigate to `http://127.0.0.1:8080/register` to add a new user to the database. Adding a user will allow you to define multiple versions of the app. If you need an admin user, you have to manually change a user's role from "user" to "admin."