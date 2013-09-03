var Friendly = {
	
	config :{
                islandType: "ocean",
                arrowType: "starfish",
                appID : null,
                maxFriendsPerCategory: 20,
                categories: {
                    'family': {
                        'title': 'Family',
                        'show': true,
                        'help': [
                                    'Please enter the names (using initials if necessary) of your family members who you know personally and would like to continue to have a personal relationship with.',
                                    'Click on a name if you need to remove it from the list.'
                                ]
                    },
                    'calling': {
                        'title': 'Calling',
                        'show': true,
                        'help': [
                                    'Please take out your phone and look at the voice call log.',
                                    'Enter the names (using initials if necessary) of everyone you know personally who you have called or received a call from IN THE LAST WEEK.',
                                    'Click on a name if you need to remove it from the list.'
                                ]
                    },
                    'texting': {
                        'title': 'Texting',
                        'show': true,
                        'help': [
                                    'Please take out your phone and look at the texting (SMS) log.',
                                    'Enter the names (using initials if necessary) of everyone you know personally who you have sent a text or have received a text from IN THE LAST WEEK.',
                                    'Click on a name if you need to remove it from the list.'
                                ]
                    },
                    'facebook': {
                        'title': 'Facebook',
                        'show': true,
                        'help': [
                                    'If you opted to authorize Friendly Island to access your Facebook account, here are the names of the most recent people you\'ve interacted with in the last week.',
                                    'Otherwise, please enter the names of everyone you have interacted with IN THE LAST WEEK.',
                                    'Click on a name if you need to remove it from the list.'
                                ]
                    },
                    'face2face': {
                        'title': 'Face to Face',
                        'show': false,
                        'help': [
                                    'Enter the first names and last initial (or nicknames) of everyone you know personally who you have seen FACE-TO-FACE IN THE LAST WEEK who is missing from your current list of islanders.'
                                ]
                    },
                    'other': {
                        'title': 'Anyone else?',
                        'show': false,
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
                                    'Please carefully go over this list and merge any duplicates. To do so, highlight each name that you want to merge into a single friend by clicking on it. When you\'ve highlighted some duplicates, click the "Next Friend" button at the top of the screen. Your merged friend will appear bolded below.',
                                    'If you make a mistake, simply double-click the merged friend to remove the names under it. Or if you forget who you have merged, hover over a bolded name to see everyone inside it.'
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

    //SNS flag
    sns: null,
  
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
            var tr = $('<tr data-fid="{fnum}"><td>{name}</td><td><input value="week" name="seen_{fnum}" type="radio" /></td><td><input value="month" name="seen_{fnum}" type="radio" /></td><td><input value="year" name="seen_{fnum}" type="radio" /></td><td><input value="overayear" name="seen_{fnum}" type="radio" /></td></tr>'.supplant({'name': obj.name, 'fnum': obj.friendNumber}));
            $(table).append(tr);
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
//Reveal function returns current slide (the slide that was just completed), so add 1 to get next slide
function updateIndex(){
    Friendly.slide = Reveal.getIndices().h + 1;
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
    var app = 'Friendly-{appID}'.supplant({'appID': Friendly.config.appID});
    return JSON.parse(window.localStorage.getItem(app));
}

//Delete application object from localStorage
function deleteApp(){
    window.localStorage.removeItem('Friendly-{appID}'.supplant({'appID': Friendly.config.appID}));
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

//Animate rehoming of elements on merge page
function disembark( element, newParent, moveAll ) {
    element = $(element); //Allow passing in either a JQuery object or selector
    newParent = $(newParent); //Allow passing in either a JQuery object or selector
    var oldOffset = element.offset();
    element.prependTo(newParent);
    var newOffset = element.offset();

    var temp = element.clone().appendTo('body');
    temp.css('position', 'absolute')
    .css('left', oldOffset.left)
    .css('top', oldOffset.top)
    .css('zIndex', 1000)
    .css('list-style', 'none');
    element.hide();
    temp.animate({
        'top': newOffset.top,
        'left': newOffset.left
    }, 
    'slow',
    'linear',
    function () {
        element.show();
        temp.remove();
    });
}

//Global variable for DataTable
var lst;

//Global object for final link network
var network = {};

//Extended permissions for Facebook
var fbPermissions = {scope: "user_about_me,friends_about_me,user_activities,friends_activities,user_birthday,friends_birthday,user_education_history,friends_education_history,user_events,friends_events,user_groups,friends_groups,user_hometown,friends_hometown,user_interests,friends_interests,user_likes,friends_likes,user_location,friends_location,user_notes,friends_notes,user_photo_video_tags,friends_photo_video_tags,user_photos,friends_photos,user_relationships,friends_relationships,user_status,friends_status,user_videos,friends_videos,read_friendlists,read_requests,read_stream,user_checkins,friends_checkins,read_mailbox"}

//Icons for final network visualization
var icons = ["starfish.png", "hut.png", "statue.png", "tree.png"];

//Colors for circles
var circleColors = $.shuffle(["rgba(217,65,65,1)", "rgba(219,110,66,1)", "rgba(221,155,66,1)", "rgba(222,202,67,1)", "rgba(200,224,67,1)", "rgba(156,226,68,1)", "rgba(111,228,68,1)", "rgba(69,230,73,1)", "rgba(70,232,121,1)", "rgba(70,234,169,1)", "rgba(71,236,218,1)", "rgba(71,208,238,1)", "rgba(72,161,240,1)", "rgba(72,113,242,1)", "rgba(81,73,244,1)", "rgba(132,74,245,1)", "rgba(183,74,247,1)", "rgba(235,75,249,1)", "rgba(251,75,215,1)", "rgba(253,76,166,1)"]);

$('#help').on('hidden', function(){
    var s = Reveal.getCurrentSlide();
    $(s).find('input').focus();
});

$('#next-fof').click(function( event ){
    var next = fof.nextFriend();
    if(next){
        $("#currentFOF").text(next.name);
    }
    else{
        fof.finalizeLinks();
        saveApp();
        Reveal.next();
    }
});

$("#next-merge").click(function( event ){
    merger.mergeFriends();
    $(".selected").removeClass("selected");
    var next = merger.nextFriend();
    if ( next ){
        $(".current-merge-name").text( next.innerText );
        $("#merged li").css("pointer-events", "auto");
        $(next).parent().css("pointer-events", "none");
        $(".current-merge").removeClass("current-merge");
        $(next).addClass("current-merge");
        //merger.matchSuspects( next.innerText );
    }else{
        merger.finalMerge();
        saveApp();
        Reveal.next();
        $("#next-arrow").show();
    }
});

    function friendInputHandler(event){
        var value = $(this).val().trim();
        if(event.which == 13 && value.length > 0){
            var slide = Reveal.getCurrentSlide();
            var cat = slide.dataset.category;
            var friendList = $(slide).find('.friend-list');
            var running = $(friendList).find("span").map(function( i,o ){ return o.innerText.toLowerCase(); });

            if(friendList.children().length == Friendly.config.maxFriendsPerCategory){
                error("MAXFRIENDS");
                $(this).val("");
            }
            else if( jQuery.inArray(value.toLowerCase(), running) != -1 ){
                error("NAMEDUP");
                $(this).val("");
            }
            else{
                var name = value;
                var li = $("<li></li>");
                var span = $("<span data-category='{cat}'></span>".supplant({'cat':cat})).text(name);
                $(span).on("click", function(){
                    $(this).parent().remove();
                }).css({
                    "opacity": 0,
                    "border-color": "#ff0000",
                    "background": "#ff7c7c",
                    "color": "#ffffff"
                });
                $(li).append(span);
                $(friendList).append(li);
                $('.friend-list li').tsort();
                $(this).val("");
                $(span).animate({"opacity": 1}, 500, "linear");
                var fade = setInterval(function() { 
                    $(span).removeAttr("style"); 
                    clearInterval(fade); }, 1000);   
            }
        }
        else if(event.which == 13 && value.length < 1) {
            $(this).val("");
        }
        
    }

    function yesSNS(){

        //Grab current slide
        var currentSlide = Reveal.getCurrentSlide();
        var span = $(currentSlide).find('.span12')[0];
        
        //Login to FB using SDK
        FB.login(

            //Callback for FB.login()
            function(response){

                $(span).html('<h4>Thanks! We\'re all set here. Click the <span class="arrow-type"></span> to continue.</h4>');

                //Check that we're connected
                if(response.status === 'connected'){

                    //Grab the access token and send it to the server
                    var access_token = FB.getAccessToken();
                    $.post('/get_interactions',
                           {access_token:access_token},
                           function(response){
                                var data = JSON.parse(response);
                                if( data.response === 'false' ) {
                                    noSNS('<h4>Oops! Looks like something went wrong. You\'ll have to enter the names manually. Click the <span class="arrow-type"></span> to continue</h4>');
                                }
                                else if( data.fbFriends.friends.length < 1 ){
                                    noSNS('<h4>Thanks! We\'re all set here. Click the <span class="arrow-type"></span> to continue.</h4>');
                                }
                                else {
                                    Friendly.fbFriends = data.fbFriends;
                                    fillFBList(Friendly.fbFriends.friends);
                                }
                        });
                }

                //We're not connected for some reason. Gotta bootstrap it!
                else{
                    noSNS('<h4>Oops! Looks like something went wrong. You\'ll have to enter the names manually. Click the <span class="arrow-type"></span> to continue</h4>');
                }
                $(".arrow-type").text(Friendly.config.arrowType);
            },
            
            //Scope object required for extended permissions
            fbPermissions
            );
            $(".arrow-type").text(Friendly.config.arrowType);
            Friendly.sns = true;
}

function noSNS(msg){
    var msg = msg || '<h4>No problem! Please click the <span class="arrow-type"></span> to continue.</h4>';
    var currentSlide = Reveal.getCurrentSlide();
    var span = $(currentSlide).find('.span12')[0];
    $(span).html(msg);
    var slide = $('#facebook');
    var input = $('<input class="friend-input" name="{category}-friend-input" type="text" placeholder="Type a name and press Enter"/>'.supplant({'category': $(slide).data('category')}));
    $(input).keypress(friendInputHandler);
    var header = $(slide).find('.slide-header h2');
    $(header).append(" - ").append(input);
    $(".arrow-type").text(Friendly.config.arrowType);
    Friendly.sns = false;
}

function fillFBList(friends){

    var ul = $('#facebook .friend-list');
    $(friends).each(function(i, obj){
        var cat = 'facebook';
        var id = obj[0];
        var name = obj[1].trim();
        var hash = obj[2];
        var li = $("<li></li>");
        var span = $("<span></span>").attr({
            'data-category':cat,
            'id':id,
            'data-hash':hash
        }).text(name);

        $(span).on("click", function(){
            $(this).parent().remove();

            Friendly.fbFriends.friends = jQuery.grep(Friendly.fbFriends.friends, function (n) {
                return n[0] != id;
            });

            Friendly.fbFriends.fb_fof = jQuery.grep(Friendly.fbFriends.fb_fof, function (n) {
                return n[0] != id;
            });

            Friendly.fbFriends.fb_fof = jQuery.grep(Friendly.fbFriends.fb_fof, function (n) {
                return n[1] != id;
            });
        });
        $(li).prepend(span);
        $(ul).append(li);
    });

    $(ul).children('li').tsort();
}

$('input[name="island-name"]').keypress( function( event ){
    var value = $(this).val().trim();
    if ( event.which == 13 && value.length > 0 ){
        $('#next-arrow').click();
    }
});

$('.friend-input').keypress(friendInputHandler);

$('#circle-input')
    .focus(function(){
        deselectCircle();
    })
    .keypress( function( event ) {
        var value = $(this).val().trim();
        var slide = Reveal.getCurrentSlide();
        var selected = $('#names-list').find('.selected');
        if( event.which == 13 && value.length > 0 ) {
            if( selected.length < 2 ){
                error("CIRCLESNAMES");
                return;
            }
            else{
                createCircle(value, slide, selected);
                $(this).val('').blur();
            }
        }
        else if( event.which == 13 && value.length == 0 && selected.length > 1) {
            error('CIRCLETITLE');
            $(this).focus();
        }
        return;
    });

$('#next-arrow').click(function( event ){
    var currentSlide = Reveal.getCurrentSlide();

    switch( currentSlide.id ){
        case 'objective':
            if ( $('input[name="island-name"]').val().trim().length > 0 ) {
                var islandName = $('input[name="island-name"]').val().trim();
                $('.island-name').text(islandName);
                Friendly.islandName = islandName;
            }
            else {
                error("ISLANDNAME");
                return;
            }
            break;
        case 'authorize':
            if ( !$("#authorize button").length == 0 ){
                error('FBAUTH');
                return;
            }
            break;
        case 'family':
        case 'calling':
        case 'texting':
        case 'facebook':
        case 'face2face':
        case 'other':
            var li = $( currentSlide ).find('.friend-list li');
            if( li.length < 1 ){
                if( !confirm("Are you sure you don't want to add any names?") ){
                    return;
                }
            }
            else{
                addNames( li );
            }
            break;
        case 'closeness':
            if ( !strength.validate() ) { 
                error('STRENGTH');
                return;
            }
            else {
                var vals = strength.values();
                var friends = Friendly.friends;
                $(vals).each(function(i, obj){
                    friends[i].strength = obj[0];
                    friends[i].strengthLength = obj[1];
                });
                Friendly.friends = friends;
            }
            break;
        case 'merge':
            if( confirm("Are you sure you've found all of the duplicates?") ){
                finalMerge();
            }
            else{
                return;
            }
            break;
        case 'lastSeen':
            if ( !validateLastSeen() ) {
                return;
            }
            else {
                getLastSeen();
            }
            break;
        case 'circles':
            $('.circle').each( function( i, obj ){
                var name = $(this).children('p').text();
                var members = [];
                $(obj).find('span').each( function( a, s ){
                    members.push($(s).data('friendNumber'));
                });
                var circle = { name: name, members: members };
                Friendly.circles.push(circle);
            });
            break;
        case 'friendOfFriend':
            var next = fof.nextFriend();
            if(next){
                $("#currentFOF").text(next.name);
                return;
            }
            else{
                fof.finalizeLinks();
            }
            break;
        default:
            break;
    }

    saveApp();
    Reveal.next();
});

            // Full list of configuration options available here:
            // https://github.com/hakimel/reveal.js#configuration
            Reveal.initialize({
                controls: false,
                width: 1000,
                progress: false,
                history: false,
                center: false,
                touch: true,
                overview: false,
                keyboard: false,
                rollingLinks: false,
                backgroundTransition: 'slide',
                transition: 'linear', // default/cube/page/concave/zoom/linear/fade/none

                // Optional libraries used to extend on reveal.js
                dependencies: [
                   { src: 'assets/js/classList.js', condition: function() { return !document.body.classList; } },
           //{ src: 'assets/js/remotes.js', async: true, condition: function() { return !!document.body.classList; } }
                        ]
            });

            //Debug code
    
    function generateNames(num){
        //Add names to a category list. number denotes how many names to each list, default is 20
        var number = num || 20;
        var names = ["Werner", "Humberto", "Marni", "Ruth", "Ashly", "Evelin", "Deloris", "Mignon", "Sophie", "Suk", "Isidra", "Fredia", "Yun", "Dee", "Bart", "Shantelle", "Elvin", "Carissa", "Pa", "Vito", "Dorothy", "Carri", "Roy", "Maritza", "Leida", "Ulysses", "Antonetta", "Crysta", "Catherine", "Jeromy", "Keith", "Houston", "Lu", "Joane", "Minna", "Megan", "Emelina", "Mandie", "Steven", "Martin", "Rutha", "Reid", "Suzy", "Maurine", "Evelia", "Azalee", "Letitia", "Kary", "Ryann", "Liliana", "Laree", "Izola", "Tennille", "Belia", "Josette", "Korey", "Jefferson", "Celena", "Sharri", "Argelia", "Elyse", "Eleanor", "Georgette", "Yoko", "Nicki", "Felica", "Librada", "Terrie", "Sacha", "Stefany", "Vanetta", "Afton", "Alida", "Justa", "Earline", "Melvin", "Alberto", "Curtis", "Monika", "Julianne", "Clarita", "Clemmie", "Brigette", "Adria", "Kaycee", "Johnie", "Reginia", "Marybelle", "Lawanna", "Jacquelyne", "Yuki", "Pandora", "Shery", "Ronald", "Traci", "Tatyana", "Kristen", "Noelle", "Kimberlee", "Hyo"];
        var c = 0;
        var d = 0;
        $('.friend-list').each(function(i,obj){
                    var cat = $(this).closest('section').data('category');
                    while(d < number){
                        var li = $("<li></li>").text(names[c]);
                        var span = $("<span class='delete' data-category='{cat}'></span>".supplant({'cat':cat}));
                        $(span).on("click", function(){
                            $(this).parent().remove();
                        });
                        $(li).prepend(span);
                        $(this).append(li);
                        c++;
                        d++;
                    }
                    $(this).children('li').tsort();
                    d = 0;
                });
    }
    
    //End debug code
            
            Reveal.addEventListener('end', function( event ){
                FB.getLoginStatus( function( response ){
                    switch (response.status){
                        case "connected":
                        case "not_authorized":
                            FB.logout();
                            break;
                    }
                });
                myNetwork.init( network );
                myNetwork.draw();
                var log = {
                    "friends": Friendly.friends,
                    "links": Friendly.links,
                    "pID":  pID,
                    "appID": Friendly.appID,
                    "circles": Friendly.circles
                }
                $.post("/log", JSON.stringify(log));
                $("#help-img").remove();
                deleteApp();
            });

            Reveal.addEventListener( 'circles', function( event ) {
                var slide = $('#circles');
                var fList = $('#names-list');
                var cList = $('.state-background').click( function (event) {
                                                                        event.stopPropagation(); 
                                                                        deselectCircle();
                                                                    });
                var cList = $('#circles-list').click( function (event) {
                                                                        event.stopPropagation(); 
                                                                        deselectCircle();
                                                                    });
                var nodes = $(fList).children('span');
                
                $(Friendly.friends).each( function( i, obj ) {
                    var name = obj.name;
                    var friendNumber = obj.friendNumber;
                    var span = $('<span class="no-text-select"></span>')
                    .data({
                        friendNumber: friendNumber,
                    })
                    .click( function( e ){
                        var circle = $(".circle-selected")[0];
                        if(circle){
                            toggleCircleMember(this, circle);
                        }
                        else{
                            $(this).toggleClass('selected');
                        }
                    })
                    .text(name);
                    $(fList).append(span);
                });
                
                $(nodes).tsort();
            });

Reveal.addEventListener('friendOfFriend', function( event ) {
    $("#next-arrow").remove();
    var slide = $('#friendOfFriend');
    var row = $(slide).find('.row')[0];

                //Generate links from circle data
                $(Friendly.circles).each( function( i, obj ){
                    var combos = buildLinks(obj.members, 2);
                    $(combos).each( function( n, c ){
                        addLink(c[0], c[1]);
                    });
                });
                
                //Generate links from Facebook data
                $(Friendly.fbFriends.fb_fof).each(function( i, obj ){
                    var s = obj[0];
                    var t = obj[1];
                    var arr = [];
                    $(Friendly.friends).each(function( a, b ){
                        $(b.category).each(function( c, d ){
                            if( d == s || d == t){
                                arr.push(b.friendNumber);
                            }
                        });
                    });
                    addLink( arr[0], arr[1] );
                });

                var firstFriend=fof.init(Friendly.friends, Friendly.links);
                $("#currentFOF").text(firstFriend.name);
                fof.addCenterFriend(firstFriend);
            });

Reveal.addEventListener('lastSeen', function( event ) {
    //Build lastSeen table
    buildLastSeen();
    
    //Settings for DataTables custom pagination
    /* Time between each scrolling frame */
    $.fn.dataTableExt.oPagination.iTweenTime = 100;

    $.fn.dataTableExt.oPagination.scrolling = {
        "fnInit": function ( oSettings, nPaging, fnCallbackDraw )
        {
            /* Store the next and previous elements in the oSettings object as they can be very
             * usful for automation - particularly testing
             */
             var nPrevious = document.createElement( 'button' );
             var nNext = document.createElement( 'button' );

             if ( oSettings.sTableId !== '' )
             {
                nPaging.setAttribute( 'id', oSettings.sTableId+'_paginate' );
                nPrevious.setAttribute( 'id', oSettings.sTableId+'_previous' );
                nNext.setAttribute( 'id', oSettings.sTableId+'_next' );
            }
            
            nPaging.setAttribute( 'class', 'paging-div' );
            nPrevious.setAttribute( 'class', 'paginate_disabled_previous' );
            nNext.setAttribute( 'class', 'paginate_disabled_next' );

            nPrevious.title = oSettings.oLanguage.oPaginate.sPrevious;
            nNext.title = oSettings.oLanguage.oPaginate.sNext;

            nPrevious.textContent = oSettings.oLanguage.oPaginate.sPrevious;
            nNext.textContent = oSettings.oLanguage.oPaginate.sNext;
            
            nPaging.appendChild( nPrevious );
            nPaging.appendChild( nNext );

            $(nPrevious).click( function() {
                /* Disallow paging event during a current paging event */
                if ( typeof oSettings.iPagingLoopStart != 'undefined' && oSettings.iPagingLoopStart != -1 )
                {
                    return;
                }

                oSettings.iPagingLoopStart = oSettings._iDisplayStart;
                oSettings.iPagingEnd = oSettings._iDisplayStart - oSettings._iDisplayLength;

                /* Correct for underrun */
                if ( oSettings.iPagingEnd < 0 )
                {
                  oSettings.iPagingEnd = 0;
              }

              var iTween = $.fn.dataTableExt.oPagination.iTweenTime;
              var innerLoop = function () {
                if ( oSettings.iPagingLoopStart > oSettings.iPagingEnd ) {
                    oSettings.iPagingLoopStart--;
                    oSettings._iDisplayStart = oSettings.iPagingLoopStart;
                    fnCallbackDraw( oSettings );
                    setTimeout( function() { innerLoop(); }, iTween );
                } else {
                    oSettings.iPagingLoopStart = -1;
                }
            };
            innerLoop();
        } );

    $(nNext).click( function() {
    /* Disallow paging event during a current paging event */
    if ( typeof oSettings.iPagingLoopStart != 'undefined' && oSettings.iPagingLoopStart != -1 )
    {
    return;
    }
    else if ( !validateLastSeen() )
    {
    return;
    }

    oSettings.iPagingLoopStart = oSettings._iDisplayStart;

    /* Make sure we are not over running the display array */
    if ( oSettings._iDisplayStart + oSettings._iDisplayLength < oSettings.fnRecordsDisplay() )
    {
    $(nNext).css("visible", "hidden");
    oSettings.iPagingEnd = oSettings._iDisplayStart + oSettings._iDisplayLength;
    }

    var iTween = $.fn.dataTableExt.oPagination.iTweenTime;
    var innerLoop = function () {
    if ( oSettings.iPagingLoopStart < oSettings.iPagingEnd ) {
    oSettings.iPagingLoopStart++;
    oSettings._iDisplayStart = oSettings.iPagingLoopStart;
    fnCallbackDraw( oSettings );
    setTimeout( function() { innerLoop(); }, iTween );
    } else {
    oSettings.iPagingLoopStart = -1;
    }
    };
    innerLoop();
    } );

    /* Take the brutal approach to cancelling text selection */
    $(nPrevious).bind( 'selectstart', function () { return false; } );
    $(nNext).bind( 'selectstart', function () { return false; } );
    },

    "fnUpdate": function ( oSettings, fnCallbackDraw )
    {
    if ( !oSettings.aanFeatures.p )
    {
    return;
    }

    /* Loop over each instance of the pager */
    var an = oSettings.aanFeatures.p;
    for ( var i=0, iLen=an.length ; i<iLen ; i++ )
    {
    if ( an[i].childNodes.length !== 0 )
    {
    an[i].childNodes[0].className = 
    ( oSettings._iDisplayStart === 0 ) ? 
    oSettings.oClasses.sPagePrevDisabled : oSettings.oClasses.sPagePrevEnabled;

    an[i].childNodes[1].className = 
    ( oSettings.fnDisplayEnd() == oSettings.fnRecordsDisplay() ) ? 
    oSettings.oClasses.sPageNextDisabled : oSettings.oClasses.sPageNextEnabled;
    }
    }
    }
    }

    //Run DataTable.js on lastSeenTable
     lst = $('#lastSeenTable').dataTable( {
        "bInfo":false,
        "bDestroy":true,
        "iDisplayLength": 10,
        "sPaginationType":"scrolling",
        "bSort":false,
        'bFilter':false,
        "bLengthChange":false,
        "fnDrawCallback": function( oSettings ){
            $("#lastSeenTable_paginate button").addClass("btn btn-primary");
            if( Friendly.friends.length <= 10 ){
                $("#lastSeenTable_paginate").css("display", "none")
            }
        }
    });

    lst.$("input[type='radio']").click(function(e){
        e.stopPropagation();
        $(this).closest("tr").removeClass("error");
    });
    
    lst.$("td:not(:first-child)").on({
        "mouseover": function(e){
            var pos = lst.fnGetPosition( this );
            var h = $("#lastSeenTable th")[pos[2]];
            var c = $(lst.fnGetNodes(pos[0])).children()[0];

            $(this).css("background", "rgba(255, 144, 3, 0.5)");
            $(c).css("background", "rgba(255, 144, 3, 0.5)");
            $(h).css("background", "rgba(255, 144, 3, 0.5)");
        },
        "mouseout": function(e){
            var pos = lst.fnGetPosition( this );
            var h = $("#lastSeenTable th")[pos[2]];
            var c = $(lst.fnGetNodes(pos[0])).children()[0];

            $(this).css("background", "");
            $(h).css("background", "");
            $(c).css("background", "");
        },
        "click": function(e){
            $(this).children("input").click();
        }
    });       
});

Reveal.addEventListener('merge', function( event ) {

    //Hide next arrow so they're forced to touch each person
    $("#next-arrow").hide();

    //Build friend lists
    createFriendLists( $('#merge .lists-row') );

    var spans = $("#merge .lists-row").find("span");
    var firstFriend = merger.init( spans );
    $("#merge .current-merge-name").text( firstFriend.innerText );
    
    $(firstFriend).parent().css("pointer-events", "none");
    $(firstFriend).addClass("current-merge");
    //merger.matchSuspects( firstFriend.innerText );
    });

Reveal.addEventListener( 'fragmentshown', function( event ) {
    if(event.fragment.dataset.show=="help-button"){
        $('#help-img').css('display', 'block');
    }
} );

Reveal.addEventListener( 'strengthInit', function( event ) {
    var names = [];
    $(Friendly.friends).each(function(i, obj) {
        names.push({name:obj.name, fnum: obj.friendNumber});
    });
    strength.init(names);
});

Reveal.addEventListener( 'slidechanged', function( event ) {

                //Update application position
                updateIndex();
                
                $(Reveal.getCurrentSlide()).find('input').focus();
                var show = event.currentSlide.dataset.show;
                var category = event.currentSlide.dataset.category;
                if(category){
                    $('#help #modal-label').text("Instructions - {category}".supplant({'category': Friendly.config.categories[category].title}));
                    var mb = $('#help').find('.modal-body');
                    $(mb).children().remove();
                    var helpList = Friendly.config.categories[category].help;
                    $(helpList).each(function(i,obj){
                        var p = $("<p class='lead'></p>");
                        $(p).text(obj);
                        $(mb).append(p);
                    });
                }
                else{

                }
                
                if(show){
                    switch(show){
                        case 'help':
                        $('#help').modal('show');
                        break;
                    }
                }
                
            });            

function deselectCircle(){
    $(".circle-selected").removeClass('circle-selected');
    $('#names-list .circle-member').removeClass('circle-member')
                                                          .css({'background-color':''});
}

function createCircle( value, slide, selected ){
    var titles = [];
    $('.circle-title').each( function( i, obj ){
        titles.push($(obj).text());
    });

    if( jQuery.inArray(value, titles) != -1 ){
        error("CIRCLEDUP");
        return;
    }
    $(".in").collapse("hide");
    var div = $("<div></div>").addClass('circle span2 no-text-select');
    var p = $("<p></p>").addClass("circle-title");
    var ul = $("<ul></ul>");
    var clr = circleColors.pop();
    var remove = $("<i></i>").addClass("icon-remove");
    var toggle = $("<i></i>")
                                   .addClass('icon-chevron-up toggle')
                                   .click( function ( event ){
                                        event.stopPropagation();
                                        if( $(this).hasClass("icon-chevron-up") ){
                                            $(ul).collapse("hide");
                                        }else if( $(this).hasClass("icon-chevron-down") ){
                                            $(ul).collapse("show");
                                        }
                                   });

    $(div).attr({
                'id': '{title}-circle'.supplant({'title':value.toLowerCase()})
                })
              .click( function( event ){
                    event.stopPropagation();
                    if( $(this).hasClass("circle-selected") && $(ul).hasClass('in') ) {
                        deselectCircle();
                    } else if( $(ul).hasClass("in") ) {
                        selectCircle( clr, this );
                    } else if( !$(ul).hasClass("in") ) {
                        selectCircle( clr, this );
                        $(ul).collapse('show');
                    }
                });

    $(p).css('background-color', clr).text(value);
    
    $(remove).click( function(){
                            var bg = $(this).parent().css('background-color');
                            var bg = bg.replace(/\)/, ", 1)");
                            var bg = bg.replace(/rgb/, "rgba");
                            circleColors.unshift(bg);
                            if( $(div).hasClass('circle-selected') ){
                                $('#names-list .circle-member').removeClass('circle-member').css('background-color', '');
                            }
                            $(div).remove()
                        })
                      .appendTo(p);
    
    $(toggle).appendTo(p);
    
    $(ul).attr({
                'class': 'collapse in',
                'id': value.toLowerCase() + "-list"
               })
             .on({
                "hide": function(){ 
                                $(toggle).toggleClass("icon-chevron-up").toggleClass("icon-chevron-down");
                                if( $(div).hasClass("circle-selected") ) {
                                    deselectCircle();
                                }
                            },
                "show": function(){ 
                                $(toggle).toggleClass("icon-chevron-up").toggleClass("icon-chevron-down");
                                selectCircle( clr, div );
                            }
             });

    $(selected).each( function( i, obj ){
        var li = $("<li></li>");
        $(obj).clone(true).removeClass('selected').css('background-color', '').unbind().appendTo(li);
        $(ul).append(li);
    });

    $(ul).children('li').tsort();
    $(div).append(p, ul).appendTo('#circles-list');
    
    selectCircle( clr, div );
}

function toggleCircleMember( friend, circle ){
    var ul = $(circle).children('ul');
    var clr = $(circle).children('.circle-title').css('background-color');
    if( $(friend).hasClass('circle-member') ){
        if( $(ul).children().length == 2 ){
            error("CIRCLESNAMES");
        }
        else{
            $(friend).removeClass('circle-member').css({'background-color': ''});
            $(ul).children('li').each( function( i, obj ){
                var span = $(obj).children();
                if( $(span).data('friendNumber') == $(friend).data('friendNumber') ){
                    $(this).remove();
                }
            });
        }
    }
    else{
        var clone = $(friend).clone(true).unbind().removeClass('selected');
        var li = $("<li></li>").append(clone);
        $(friend).addClass('circle-member').css({'background-color': clr});
        $(ul).append(li);
        $(ul).children('li').tsort();
    }
    return;
}

function selectCircle( clr, circle ){
    $('.selected').click();
    deselectCircle();
    $(circle).toggleClass('circle-selected');
    var allFriends = $('#names-list span');
    var members = $(circle).find('span');
    $(members).each(function( i,obj ){
        var f = jQuery.grep(allFriends, function( a,b ){
            return $(obj).data('friendNumber') == $(a).data('friendNumber');
        });
        $(f).addClass('circle-member').css({'background-color':clr});
    });
}

function error( type ) {
    var mess;
    switch( type ){
        case "MAXFRIENDS":
            mess="Sorry, you've reached the maximum number of friends for this category";
            break;
        case "STRENGTH":
            mess="Please bring all of your friends into the circle";
            break;
        case "FBAUTH":
            mess="Please choose an option.";
            break;
        case "CIRCLEDUP":
            mess="There is already a group with that title. Please choose a different title.";
            break;
        case "CIRCLETITLE":
            mess="Please pick a title for this circle.";
            break;
        case "CIRCLESNAMES":
            mess="A group needs at least 2 people.";
            break;
        case 'FOF':
            mess="FOF ERROR";
            break;
        case "ISLANDNAME":
            mess="Please enter a name.";
            break;
        case "NAMES":
            mess="Are you sure you don't want to enter any names?";
            break;
        case "LASTSEEN":
            mess="Please select missing values.";
            break;
        case "NOSPLITCURRENT":
            mess="You can't split somone who is still merging!";
            break;
        case "NAMEDUP":
            mess="You aleady have that name in this category";
            break;
    }
    $('#error').text(mess);
    $('#error').fadeIn('fast');
    var fade = setInterval(function() { 
        $("#error").fadeOut('slow'); 
        clearInterval(fade); }, 2000);
}

function select(e){
    $(e).children().toggleClass('selected');
}

function createFriendLists( targetElement ) {

     var cats = $('.category');

    //Create list for each category
    $(cats).each(function(i,obj){
         var cat = $(obj).data('category');
         var div = $("<div class='merge-div'></div>");
         var p = $("<p></p>").text(cat.capitalize());
         var ul = $("<ul id='{cat}-list' class='merge-list'></ul>".supplant({'cat':cat}));

        //Get all members of a category
        var members = jQuery.grep(Friendly.friends, function (friend) {
            return friend.category[0].search(cat) != -1;
         });

        $(members).each(function(i,obj){
             var name = obj.name;
             var friendNumber = obj.friendNumber;
             var catId = obj.category[0];
             var hash = obj.hash;
             var li = $("<li></li>").attr('onclick', 'select(this)');
             var span = $("<span></span>").data({
                 friendNumber: friendNumber,
                 catId: catId,
                 hash: hash
             })
             .attr("id", friendNumber+"-merge")
             .text(name);
             $(li).append(span);
             $(ul).append(li);
         });
            
            $(div).append(p);
            $(div).append(ul).children('li').tsort();
            $(targetElement).append(div);
    });
}

function disembarkCheck(){

}