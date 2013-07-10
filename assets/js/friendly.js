function FriendlyApp(config){
	
	this.config = {
	    appID : 1,
	    categories: {
	        'family': {
	            'show': true,
	            'help': 'Please enter the names (using initials if necessary) of your family members who you know personally and would like to continue to have a personal relationship with.'
	        },
	        'calling': {
	            'show': true,
	            'help': 'Please take out your phone and look at the voice call log. Enter the names (using initials if necessary) of everyone you know personally who you have called or received a call from IN THE LAST WEEK.'
	        },
	        'texting': {
	            'show': true,
	            'help': 'Please take out your phone and look at the texting (SMS) log. Enter the names (using initials if necessary) of everyone you know personally who you have sent a text or have received a text from IN THE LAST WEEK.'
	        },
	        'facebook': {
	            'show': true,
	            'help': 'If you opted to authorize Friendly Island to access your Facebook account, here are the names of the most recent people you\'ve interacted with in the last week. Otherwise, please enter the names of everyone you have interacted with IN THE LAST WEEK.'
	        },
	        'face2face': {
	            'show': true,
	            'help': 'Enter the first names and last initial (or nicknames) of everyone you know personally who you have seen FACE-TO-FACE IN THE LAST WEEK who is missing from your current list of islanders.'
	        },
	        'other': {
	            'show': true,
	            'help': 'Now look at the list of names one last time to see if there anyone who would not want to forget to bring. Please think of ALL SIGNIFICANT RELATIONSHIPS who might be missing from your island. This includes people who you have NOT interacted with via face-to-face, calling, texting, or Facebook in the last 7 days BUT who you know personally and would like to continue to have a personal relationship with.'
	        },
	        'closeness': {
	            'show': true,
	            'help': 'These are all the relationships who make up your island. Please rate how emotionally close you are with each one by moving their name into the circle to determine how much land they each get. You can rate them from NOT AT ALL CLOSE (perimeter) to EXTREMEMELY CLOSE (center).'
            }
	    }
	}
	
	//Island name
	this.islandName;
	
	//Max number of people for each category
	this.maxFriendsPerCategory = 20;
  
    //Current slide index used for reloading app
    this.slide = 0;
    slide = this.slide;
    
    //Running lists of friends and links for internal and external use
    this.friends = [];
    friends = this.friends;
    
    this.fbFriends = {};
    fbFriends = this.fbFriends;
    
    this.links = []
    links = this.links;
    
    //Define Friend object
    function Friend(name, id, hash){
        this.name = name;
        this.friendNumber = "f{number}".supplant({'number':friends.length + 1});
        this.category = [id];
        this.hash = hash;
    };
    
    //Add names from friend-list to application object
    FriendlyApp.prototype.addNames = function(li){
        $(li).each(function(i,obj){
            var name = $(obj).text();
            var span = $(obj).children();
            var category = $(span).data('category');
            var hash = $(span).data('hash') || null;
            var number = i+1;
            var id = $(span).attr('id') || "{category}_f{number}".supplant({'category':category,'number':number});
            var friend = new Friend(name, id, hash);
            friends.push(friend);
        });
    }
    
    //Add links to application object
    FriendlyApp.prototype.addLink = function(source, target){
        var link = {source:source, target:target};
        this.links.push(link);
    }
    
    //Save application object to localStorage
    FriendlyApp.prototype.saveApp = function(){
        this.updateIndex();
        window.localStorage.setItem('FriendlyApp-{appID}'.supplant({'appID': this.config.appID}), JSON.stringify(this));
    }
    
    //Retrieve application object from localStorage
    FriendlyApp.prototype.getApp = function(){
        return JSON.parse(window.localStorage.getItem('FriendlyApp-{appID}'.supplant({'appID': this.config.appID})));
    }
    
    //Update application position
    FriendlyApp.prototype.updateIndex = function(){
        this.slide = Reveal.getIndices().h;
    }
    
}

//Extended permissions for Facebook
var fbPermissions = {scope: "user_about_me,friends_about_me,user_activities,friends_activities,user_birthday,friends_birthday,user_education_history,friends_education_history,user_events,friends_events,user_groups,friends_groups,user_hometown,friends_hometown,user_interests,friends_interests,user_likes,friends_likes,user_location,friends_location,user_notes,friends_notes,user_photo_video_tags,friends_photo_video_tags,user_photos,friends_photos,user_relationships,friends_relationships,user_status,friends_status,user_videos,friends_videos,read_friendlists,read_requests,read_stream,user_checkins,friends_checkins,read_mailbox"}

//Helper function for string formatting
String.prototype.supplant = function (o) {
      return this.replace(/{([^{}]*)}/g,
        function (a, b) {
              var r = o[b];
              return typeof r === 'string' || typeof r === 'number' ? r : a;
          }
      );
};

//Capitalize a string
String.prototype.capitalize = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
};