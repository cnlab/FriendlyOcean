var Friendly = {
	
	config :{
                appID : 1,
                categories: {
                    'family': {
                        'title': 'Family',
                        'show': true,
                        'help': [
                                    'Please enter the names (using initials if necessary) of your family members who you know personally and would like to continue to have a personal relationship with.'
                                ]
                    },
                    'calling': {
                        'title': 'Calling',
                        'show': true,
                        'help': [
                                    'Please take out your phone and look at the voice call log.',
                                    'Enter the names (using initials if necessary) of everyone you know personally who you have called or received a call from IN THE LAST WEEK.'
                                ]
                    },
                    'texting': {
                        'title': 'Texting',
                        'show': true,
                        'help': [
                                    'Please take out your phone and look at the texting (SMS) log.',
                                    'Enter the names (using initials if necessary) of everyone you know personally who you have sent a text or have received a text from IN THE LAST WEEK.'
                                ]
                    },
                    'facebook': {
                        'title': 'Facebook',
                        'show': true,
                        'help': [
                                    'If you opted to authorize Friendly Island to access your Facebook account, here are the names of the most recent people you\'ve interacted with in the last week.',
                                    'Otherwise, please enter the names of everyone you have interacted with IN THE LAST WEEK.'
                                ]
                    },
                    'face2face': {
                        'title': 'Face to Face',
                        'show': true,
                        'help': [
                                    'Enter the first names and last initial (or nicknames) of everyone you know personally who you have seen FACE-TO-FACE IN THE LAST WEEK who is missing from your current list of islanders.'
                                ]
                    },
                    'other': {
                        'title': 'Anyone else?',
                        'show': true,
                        'help': [
                                    'Now look at the list of names one last time to see if there anyone who would not want to forget to bring.',
                                    'Please think of ALL SIGNIFICANT RELATIONSHIPS who might be missing from your island. This includes people who you have NOT interacted with via face-to-face, calling, texting, or Facebook in the last 7 days BUT who you know personally and would like to continue to have a personal relationship with.'
                                ]
                    },
                    'merge': {
                        'title': 'Merge',
                        'show': true,
                        'help': [
                                    'Ok, time to disembark. However, before getting off the ship, we need to get an accurate head count.',
                                    'We know that sometimes you communicate with the same person via multiple channels. For example, maybe you text your mother and talk to her on the phone.',
                                    'Please carefully go over this list and merge any duplicates. To do so, highlight each name that you want to merge into a single friend by clicking on it. When you\'ve highlighted some duplicates, click the "Merge" button at the top of the screen. Your merged friend will appear in the list at the right.',
                                    'If you make a mistake, simply double-click the merged friend to separate it. Or if you find that you missed a name and need to add it to an already merged friend, simply highlight that name and the merged name and click "Merge."'
                                ]
                    },
                    'closeness': {
                        'title': 'Closeness',
                        'show': true,
                        'help': [
                                    'These are all the relationships who make up your island. Please rate how emotionally close you are with each one by moving their name into the circle to determine how much land they each get.',
                                    'You can rate them from NOT AT ALL CLOSE (perimeter) to EXTREMEMELY CLOSE (center).'
                                ]
                    },
                    'lastSeen': {
                        'title': 'Last Seen',
                        'show': true,
                        'help': [
                                    'Okay, you have now brought over the first four boats of contacts to your island. These are the family members you know and the friends you\'ve interacted with in the past week.',
                                    'Before moving on to the next boat, please indicate the last time you saw each of them face-to-face.'
                                ]
                    },
                    'circles': {
                        'title': 'Your circles',
                        'show': true,
                        'help': [
                                    'All right. Let\'s put some people in some circles.'
                                ]
                    },
                    'friendOfFriend': {
                        'title': 'Friends of Friends',
                        'show': true,
                        'help': [
                                    'Next, put your friends who know each other together in the same place on the island. For each friend bring the people they know to the same side of the island by clicking on their circle. If you make a mistake you can click again to return them to the other side of the island.'
                                ]
                    },
                    'end': {
                        'title': 'The End',
                        'show': true,
                        'help': [
                                    'You\'re all done!'
                                ]
                    }
                }
            },
	
	//Island name
	islandName: null,

	//Max number of people for each category
	maxFriendsPerCategory: 20,
  
    //Current slide index used for reloading app
    slide: 0,
    
    //Running lists of friends, links, and circles
    friends: [],
    
    fbFriends: {},
    
    links: [],
    
    circles: []
    
}

//Get and set values from Last See Table
function getLastSeen() {
    var inputs = lst ? lst.$('input:checked') : $('input:checked');
    $(inputs).each(function( i, obj ) {
        var value = $(obj).val();
        var fnum = obj.name.split("_")[1];
        var friend = jQuery.grep(Friendly.friends, function ( f ) {
            return f.friendNumber == fnum;
        })[0];
        
        friend.lastSeen = value;
    });
}

//Validate Last Seen Table
function validateLastSeen() {
  
  //Get all rows via DataTables api
  var rows = $("#lastSeenTable tbody tr");
  
  var missingCnt=0;
  
  $(rows).each(function( i, obj ) {
    var inputs = $(obj).find('input');
    var isSelected = inputs[0].checked || inputs[1].checked || inputs[2].checked || inputs[3].checked;
    
    if (isSelected) {
      $(obj).removeClass('error');
    } 
    else {
      $(obj).addClass('error');
      missingCnt++;
    }
  });

  if (missingCnt==0) {
    return true;
  } 
  else {
    error("LASTSEEN");
    return false;
  }
}

//Build lastSeen table
function buildLastSeen() {
    var table = $('#lastSeenTable');
    var friends = Friendly.friends.sort(function( a, b ){
        var aName = a.name.toLowerCase();
        var bName = b.name.toLowerCase(); 
        return ((aName < bName) ? -1 : ((aName > bName) ? 1 : 0));
    });
    
    $(friends).each(function( i, obj ) {
        var tr = $('<tr data-fid="{fnum}"><td>{name}</td><td><input value="week" name="seen_{fnum}" type="radio" /></td><td><input value="month" name="seen_{fnum}" type="radio" /></td><td><input value="year" name="seen_{fnum}" type="radio" /></td><td><input value="overayear" name="seen_{fnum}" type="radio" /></td>'.supplant({'name': obj.name, 'fnum': obj.friendNumber}));
        $(table).append(tr);
    });
}

//Merge friends for good
function finalMerge(){
    var merged = [];
    var friend_list = $('.merge-list li');
    $(friend_list).each(function( i, li ){
        var span = $(li).children();
        var data = $(span).data();
        if ( data.hasOwnProperty('merged') ) {
            var mainFriend = $(Friendly.friends).filter(function( i ) {
                return this.friendNumber == data.merged[0].friendNumber;
            })[0];
            
            $(data.merged).each(function(i,obj){
                if ( obj.friendNumber != mainFriend.friendNumber ){
                    mainFriend.category.push(obj.catId);
                    $(Friendly.friends).each(function(a,b){
                        if (b.friendNumber == obj.friendNumber) {
                            Friendly.friends.splice(a,1);
                        }
                    });
                }
            });
        }
    });
}

//Add names from friend-list to application object
function addNames(li){
    $(li).each(function(i,obj){
        var name = $(obj).text();
        var span = $(obj).children();
        var category = $(span).data('category');
        var hash = $(span).data('hash') || null;
        var number = i+1;
        var id = $(span).attr('id') || "{category}_f{number}".supplant({'category':category,'number':number});
        var friend = new Friend(name, id, hash);
        Friendly.friends.push(friend);
    });
}

//Update application position
function updateIndex(){
    Friendly.slide = Reveal.getIndices().h;
}
    
//Define Friend object
function Friend(name, id, hash){
    this.name = name;
    this.friendNumber = "f{number}".supplant({'number':Friendly.friends.length + 1});
    this.category = [id];
    this.hash = hash;
}

//Add links to application object
function addLink(source, target){

    //Check links in case two people are in two groups together or already friends on FB
    function checkLink( ls, lt ){
        var result = true;
        $(Friendly.links).each(function(i, o){
            if( (o.source === ls && o.target === lt) || (o.source === lt && o.target === ls) ){
                result = false;
            }
        });
        
        return result;
    }
    
    if( checkLink( source, target ) ){
        var link = {source:source, target:target};
        Friendly.links.push(link);
    }
    
}

//Save application object to localStorage
function saveApp(){
    updateIndex();
    window.localStorage.setItem('Friendly-{appID}'.supplant({'appID': Friendly.config.appID}), JSON.stringify(Friendly));
}

//Retrieve application object from localStorage
function getApp(){
    return JSON.parse(window.localStorage.getItem('Friendly-{appID}'.supplant({'appID': Friendly.config.appID})));
}

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

//Add shuffle function to jQuery NS
(function($){

    $.fn.shuffle = function() {
        return this.each(function(){
        var items = $(this).children().clone(true);
        return (items.length) ? $(this).html($.shuffle(items)) : this;
        });
    }

    $.shuffle = function(arr) {
        for(var j, x, i = arr.length; i; j = parseInt(Math.random() * i), x = arr[--i], arr[i] = arr[j], arr[j] = x);
        return arr;
    }

})(jQuery);

//Create links given an array where n is the number of members per link
function buildLinks(array, n) {
    /*
    derived from: https://gist.github.com/doph/3118596
    */
    var i, j, combs, head, tailcombs;

    if (n > array.length || n <= 0) {
        return [];
    }

    if (n == array.length) {
        return [array];
    }

    if (n == 1) {
        combs = [];
        for (i = 0; i < array.length; i++) {
            combs.push([array[i]]);
        }
    return combs;
    }
    combs = [];
    for (i = 0; i < array.length - n + 1; i++) {
        head = array.slice(i, i+1);
        tailcombs = buildLinks(array.slice(i + 1), n - 1);
        for (j = 0; j < tailcombs.length; j++) {
            combs.push(head.concat(tailcombs[j]));
        }
    }
    
    return combs;
}

//Global variable for DataTable
var lst;

//Global object for final link network
var network = {};

//Extended permissions for Facebook
var fbPermissions = {scope: "user_about_me,friends_about_me,user_activities,friends_activities,user_birthday,friends_birthday,user_education_history,friends_education_history,user_events,friends_events,user_groups,friends_groups,user_hometown,friends_hometown,user_interests,friends_interests,user_likes,friends_likes,user_location,friends_location,user_notes,friends_notes,user_photo_video_tags,friends_photo_video_tags,user_photos,friends_photos,user_relationships,friends_relationships,user_status,friends_status,user_videos,friends_videos,read_friendlists,read_requests,read_stream,user_checkins,friends_checkins,read_mailbox"}

//Icons for final network visualization
var icons = ["starfish.png", "hut.png", "statue.png", "tree.png"];

//Array of colors for circles
var circleColors = $.shuffle(["rgba(217,65,65,1)", "rgba(219,110,66,1)", "rgba(221,155,66,1)", "rgba(222,202,67,1)", "rgba(200,224,67,1)", "rgba(156,226,68,1)", "rgba(111,228,68,1)", "rgba(69,230,73,1)", "rgba(70,232,121,1)", "rgba(70,234,169,1)", "rgba(71,236,218,1)", "rgba(71,208,238,1)", "rgba(72,161,240,1)", "rgba(72,113,242,1)", "rgba(81,73,244,1)", "rgba(132,74,245,1)", "rgba(183,74,247,1)", "rgba(235,75,249,1)", "rgba(251,75,215,1)", "rgba(253,76,166,1)"]);