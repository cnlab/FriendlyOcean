<!doctype html>
<html lang="en">

	<head>
		<meta charset="utf-8">

		<title>Friendly Island</title>

		<meta name="apple-mobile-web-app-capable" content="yes" />
		<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />

		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
		<link rel="stylesheet" href="assets/css/reveal.css">
		<link rel="stylesheet" href="assets/css/theme/jp.css" id="theme">
		<link rel="stylesheet" href="assets/css/common.css">
		
		<!--[if lt IE 9]>
		<script src="assets/js/html5shiv.js"></script>
		<![endif]-->
	</head>

	<body>
	
        <!--Facebook SDK for login-->
    
        <div id="fb-root"></div>
        <script>
            window.fbAsyncInit = function() {
            // init the FB JS SDK
                FB.init({
                  appId      : '184250398371980',
                  channelUrl : '/channel',
                  cookie     : true,
                  status     : true,
                  xfbml      : false,
                  oauth      : true
                });
            };

            // Load the SDK asynchronously
            (function(d, s, id){
                 var js, fjs = d.getElementsByTagName(s)[0];
                 if (d.getElementById(id)) {return;}
                 js = d.createElement(s); js.id = id;
                 js.src = "//connect.facebook.net/en_US/all.js";
                 fjs.parentNode.insertBefore(js, fjs);
                }(document, 'script', 'facebook-jssdk'));
        </script>
    
        <!--End Facebook SDK for login-->

        <a id="help-img" data-toggle="modal" href="#help"></a>
        <div id="next-arrow"></div>
		<div class="reveal">

			<!-- Any section element inside of this container is displayed as a slide -->
			<div class="slides">

                <section id="title">
                    <div class="row">
                        <div class="span5">
                            <h1>Friendly<br/>Island</h1>
                            <p>Click the arrow to begin!</p>
                        </div>
                    </div>
                </section>
                
                <section id="authorize">
                    <div class="page-header">
                        <h2>Facebook Authorization</h2>
                    </div>
                    <div class="row">
                        <div class="span12">
                            <p>This application would like to access your Facebook account in order to grab the names of friends you've interacted with in the past week. Once you complete the game, you will be logged out of Facebook and your friend's names will be anonymized. Alternatively, you can enter them manually... but that's just more work for you.</p> 
                        </div>
                        <div class="span12">
                            <p>
                                <button class="btn btn-success" onclick="yesSNS();">Log in</button>
                            </p>
                            <h5>
                                <a href="javascript:void(0);" onclick="noSNS();">No thanks</a>
                            </h5>
                        </div>                
                    </div>
                </section>
                
                <section id="congratulations">
                    <div class="page-header">
                        <h2>Congratulations!</h2>
                    </div>
                    <p>
                        You have just been awarded an empty tropical island for you and all of your friends and family.
                    </p>
                    <p class="fragment">
                        This study is trying to understand how individuals’ islands (or social networks) are different from one another in the 21st Century.
                    </p>
                </section>
                
                <section id="objective" data-transition="none">
                    <div class="row">
                        <div class="page-header">
                            <h3>Your Goal</h3>
                        </div>
                            <p>
                            Populate your island with everyone in your social network that you talk to regularly or know personally.
                        </p>
                    </div>
                    <div class="row">
                        <h3>Before you get started...</h3>
                        <p>
                            <span class="inline-help">Name your island </span>
                            <input class="input-large" name="island-name" type="text"/>
                            <span class="inline-help"> and press enter.</span>
                        </p>
                    </div>                
                </section>
                
                <section class="instructions" data-transition="none">
                    <div class="page-header">
                        <h3>Instructions</h3>
                    </div>
                    <p>Now, you need to bring over some people to join you on <span class='islandName'></span>.</p>
                    <p>Please read the following instructions carefully before beginning the game...</p>
                </section>
                
                <section class="instructions" data-transition="none">
                    <div class="page-header">
                        <h3>Instructions</h3>
                    </div>
                    <p>During the game, you will be asked to enter the first name and initial (or a nickname like “Mom” or “Matt from School”) of your family, friends, and acquaintances who you interact with on a normal basis and know personally.</p>
                    <p>The reason to enter names with initials (or a nickname) is so that you can keep track of which person is which throughout the game.</p>
                </section>
                
                <section class="instructions" data-transition="none">
                    <div class="page-header">
                        <h3>Instructions</h3>
                    </div>
                    <p>On <span class='islandName'></span>, each of your personal relationships will each get their own piece of the island.</p>
                    <p>In order for your to build the most complete island civilization, you will bring people over in six different boats.</p>
                    <div class="span5 offset2">
                        <ol>
                            <li>Family</li>
                            <li>Calling</li>
                            <li>Texting</li>
                            <li>Facebook</li>
                            <li>Face-to-face</li>
                            <li>Everyone else</li>
                        </ol>
                    </div>
                </section>
                
                <section class="instructions" data-transition="none">
                    <div class="page-header">
                        <h3>Instructions</h3>
                    </div>
                    <p>After you have transported everyone to <span class='islandName'></span>, you will then decide how much land they get based on how close you are to them.</p>
                    <p>Finally, you will decide who will live on the same part of the island as other individuals based on who knows who.</p>
                </section>
                
                <section class="instructions" data-transition="none">
                    <div class="page-header">
                        <h3>Three more important things</h3>
                    </div>
                    <div class="row fragment">
                        <h3>1&#41; Privacy</h3>
                        <p>After you have finished the game, we will remove <span class="underline">all</span> of your friends’ names/nicknames automatically so that your social network is <span class="underline">completely anonymous</span>.</p>
                    </div>
                    <div class="row fragment" data-show="help-button">
                        <h3>2&#41; Help</h3>
                        <p>You'll receive instructions along the way. If you ever need to revisit them, you can click the question mark in the upper left-hand corner. Give it a try right now!</p>
                    </div>
                    <div class="row fragment">
                        <h3>3&#41; Have fun!</h3>
                    </div>
                </section>
                
                <section id="family" data-category="family" data-show="help" class="category add-names">
                    <div class="page-header">
                        <h2>Family - <input class="friend-input" name="calling-friend-input" type="text" placeholder="Type a name and press Enter"/></h2>
                    </div>
                    <ul class="friend-list">
                    </ul>
                </section>
                
                <section id="calling" data-category="calling" data-show="help" class="category add-names">
                    <div class="page-header">
                        <h2>Calling - <input class="friend-input" name="calling-friend-input" type="text" placeholder="Type a name and press Enter"/></h2>
                    </div>
                    <ul class="friend-list">
                    </ul>
                </section>
                
                <section id="texting" data-category="texting" data-show="help" class="category add-names">
                    <div class="page-header">
                        <h2>Texting - <input class="friend-input" name="texting-friend-input" type="text" placeholder="Type a name and press Enter"/></h2>
                    </div>
                    <ul class="friend-list">
                    </ul>
                </section>
                
                <section id="facebook" data-category="facebook" data-show="help" class="category add-names sns">
                    <div class="page-header">
                        <h2>Facebook</h2>
                    </div>
                    <ul class="friend-list">
                    </ul>
                </section>
                
                <section id="merge" data-state="merge" data-category="merge" data-show="help" class="merge">
                    <div class="container">
                        <div class="row">
                            <button class="btn btn-large" onclick="mergeFriends();">Merge</button>
                        </div>
                        <div class="row">
                            <!--Leave this space empty. Lists are dynamically generated.-->
                        </div>
                    </div>
                </section>
                
                <section id="closeness" data-category="closeness" data-show="help" data-state="strengthInit" class="chart">
                <!--Leave this space empty. It is where the svg canvas is inserted when strength.js is initiated-->
                </section>
                
                <section id="lastSeen" data-state="lastSeen" data-category="lastSeen" data-show="help">
                    <div class="container">
                        <table id="lastSeenTable" class="table table-striped table-condensed">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Within the last week</th>
                                    <th>More than a week ago but within the last month</th>
                                    <th>More than a month ago but within the last year</th>
                                    <th>More than a year ago</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </section>
                
                <section data-state="end">
                    <div class="page-header"> 
                        <h2>End so far...</h2>
                    </div>
                    <p>See console log for the output of the current application</p>
                </section>
                
			</div>
            
		</div>
		
		<!--Begin help modal-->
		
		<div id="help" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="help" aria-hidden="true">
          <div class="modal-header">
            <h2 id="modal-label">Instructions</h2>
          </div>
          <div class="modal-body">
            <p class="lead">Woo! You found the help!</p>
          </div>
          <div class="modal-footer">
            <button class="btn btn-info btn-large" data-dismiss="modal" aria-hidden="true">OK</button>
          </div>
        </div>
        
        <!--/End help modal-->
        
        <!--Error div for strength.validate()-->
        <div id="error"></div>
        
        <!--Javascripts-->
		<script src="assets/js/jquery-1.10.1.min.js"></script>
		<script src="assets/js/jquery.tinysort.min.js"></script>
		<script src="assets/js/bootstrap.min.js"></script>
    	<script src="assets/js/reveal.js"></script>
    	<script src="assets/friendly/friendly.js"></script>
    	<script src="assets/js/strength.js"></script>
    	<script src="assets/js/d3.v2.js"></script>
    	<script src="assets/js/jquery.dataTables.min.js"></script>
    	
		<script type="text/javascript">
		
            //Global variable used in lastSeen section
            var lst;
            
            $('#help').on('hidden', function(){
                $(Reveal.getCurrentSlide()).find('input').focus();
            });
            
            function friendInputHandler(event){
                var value = $(this).val().trim();
                if(event.which == 13 && value.length > 0){
                    var slide = Reveal.getCurrentSlide();
                    var cat = slide.dataset.category;
                    var friendList = $(slide).find('.friend-list');
                                        
                    if(friendList.children().length == Friendly.maxFriendsPerCategory){
                        alert("Sorry, you've reached the maximum number of friends for this category");
                        $(this).val("");
                    }
                    else{
                        var name = $(this).val();
                        var li = $("<li></li>").text(name);
                        var span = $("<span class='delete' data-category='{cat}'></span>".supplant({'cat':cat}));
                        $(span).on("click", function(){
                            $(this).parent().remove();
                        });
                        $(li).prepend(span);
                        $(friendList).append(li);
                        $('.friend-list li').tsort();
                        $(this).val("");            
                    }
                }
                else if(event.which == 13 && value.length < 1) {
                    $(this).val("");
                }
            }

            function yesSNS(){
                
                //Grab current slide
                var currentSlide = Reveal.getCurrentSlide();
                var span = $(currentSlide).find('.span12')[1];
                $(span).html('<p>Loading...</p><div class="progress progress-striped active"><div class="bar" style="width: 100%;"></div></div>');
                
                //Login to FB using SDK
                FB.login(
                
                    //Callback for FB.login()
                    function(response){
                    
                        //Check that we're connected
                        if(response.status === 'connected'){
                        
                            //Grab the access token and send it to the server
                            var access_token = FB.getAccessToken();
                            $.post('/get_interactions',
                                {access_token:access_token},
                                function(response){
                                    var data = JSON.parse(response);
                                    if(data.response === 'false') {
                                        noSNS('<h4>Oops! Looks like something went wrong. You\'ll have to enter the names manually. Click the arrow to continue</h4>');
                                    }
                                    else {
                                        Friendly.fbFriends = data.fbFriends;
                                        $(span).html('<h4>Thanks! We\'re all set here. Click the arrow to continue.</h4>');
                                        fillFBList(Friendly.fbFriends.friends);
                                    }
                                });
                        }
                        
                        //We're not connected for some reason. Gotta bootstrap it!
                        else{
                            noSNS('<h4>Oops! Looks like something went wrong. You\'ll have to enter the names manually. Click the arrow to continue</h4>');
                        }
                    },
                    
                    //Scope object required for extended permissions
                    fbPermissions
                );
            }
            
            function noSNS(msg){
                var msg = msg || '<h4>No problem! Please click the arrow to continue.</h4>';
                var currentSlide = Reveal.getCurrentSlide();
                var span = $(currentSlide).find('.span12')[1];
                $(span).html(msg);
                var slide = $('#facebook');
                $(slide).find('.container').remove();
                var input = $('<input class="friend-input" name="{category}-friend-input" type="text" placeholder="Type a name and press Enter"/>'.supplant({'category': $(slide).data('category')}));
                $(input).keypress(friendInputHandler);
                var header = $(slide).find('h2');
                $(header).append(" - ").append(input);
            }
            
            function fillFBList(friends){
            
                var ul = $('#facebook .friend-list');

                $(friends).each(function(i, obj){
                    var cat = 'facebook';
                    var id = obj[0];
                    var name = obj[1].trim();
                    var hash = obj[2];
                    var li = $("<li></li>").text(name);
                    var span = $("<span></span>").attr({
                            'class':'delete',
                            'data-category':cat,
                            'id':id,
                            'data-hash':hash
                        });
                        
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
                
                $(ul).tsort();
            }
            
            $('.friend-input').keypress(friendInputHandler);
            
            $('#next-arrow').click(function( event ){
                var currentSlide = Reveal.getCurrentSlide();
                
                switch( currentSlide.id ){
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
                        finalMerge();
                        break;
                    case 'lastSeen':
                        if ( !validateLastSeen() ) {
                            return;
                        }
                        else {
                            getLastSeen();
                        }
                        break;                       
                    default:
                        break;
                }

                saveApp();
                Reveal.next();
            });
                        
            $('input[name="island-name"]').keypress(function(event){
                var value = $(this).val().trim()
                if(event.which == 13 && value.length > 0){
                    $('.islandName').text($('input[name="island-name"]').val());
                    var row = $(Reveal.getCurrentSlide()).children('.row')[1];
                    var islandName = $('input[name="island-name"]').val();
                    $(row).html("<h3>Welcome to " + islandName + "!</h3>");                     
                    Friendly.islandName = islandName;
                    saveApp();                     
                }
                else if(event.which == 13 && value.length < 1){
                    $(this).val("");
                }
            });

            // Full list of configuration options available here:
            // https://github.com/hakimel/reveal.js#configuration
            Reveal.initialize({
				controls: false,
				progress: true,
				history: true,
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
			
			Reveal.addEventListener('end', function( event ){
			    console.log(JSON.stringify(getApp()), undefined, 2);
			    FB.logout();
			});
			
			function generateNames(number){
			    //Add names to a category list. number denotes how many names to each list
			    var names = ["Werner", "Humberto", "Marni", "Ruth", "Ashly", "Evelin", "Deloris", "Mignon", "Sophie", "Suk", "Isidra", "Fredia", "Yun", "Dee", "Bart", "Shantelle", "Elvin", "Carissa", "Pa", "Vito", "Dorothy", "Carri", "Roy", "Maritza", "Leida", "Ulysses", "Antonetta", "Crysta", "Catherine", "Jeromy", "Keith", "Houston", "Lu", "Joane", "Minna", "Megan", "Emelina", "Mandie", "Steven", "Martin", "Rutha", "Reid", "Suzy", "Maurine", "Evelia", "Azalee", "Letitia", "Kary", "Ryann", "Liliana", "Laree", "Izola", "Tennille", "Belia", "Josette", "Korey", "Jefferson", "Celena", "Sharri", "Argelia", "Elyse", "Eleanor", "Georgette", "Yoko", "Nicki", "Felica", "Librada", "Terrie", "Sacha", "Stefany", "Vanetta", "Afton", "Alida", "Justa", "Earline", "Melvin", "Alberto", "Curtis", "Monika", "Julianne", "Clarita", "Clemmie", "Brigette", "Adria", "Kaycee", "Johnie", "Reginia", "Marybelle", "Lawanna", "Jacquelyne", "Yuki", "Pandora", "Shery", "Ronald", "Traci", "Tatyana", "Kristen", "Noelle", "Kimberlee", "Hyo"];
			    var c = 0;
			    var d = 0;
			    $('.friend-list').each(function(i,obj){
                    var cat = $(this).parent().data('category');
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
			        $(this).tsort();
			        d = 0;
			    });
			}
			
			//End debug code

			Reveal.addEventListener('lastSeen', function( event ) {
			    //Build lastSeen table
			    buildLastSeen();
			    
			    //Run DataTable.js on lastSeen table for pagination, if needed
			    if ( Friendly.friends.length > 20 ) {
			        lst = $('#lastSeenTable').dataTable( {
                        "bInfo":false,
                        "bDestroy":true,
                        "iDisplayLength": 20,
                        "sPaginationType":"scrolling",
                        "bSort":false,
                        'bFilter':false,
                        "bLengthChange":false,
                    });
			    }
			    
			    //Style pagination buttons because DataTables hates JP
			    $('.paging-div button').addClass("btn btn-primary");
			    
			});
			
			Reveal.addEventListener('merge', function( event ) {
                var slide = $('#merge .row')[1];
			    var cats = $('.category');
			    
			    //Create list for each category
			    $(cats).each(function(i,obj){
			        var cat = $(obj).data('category');
			        var div = $("<div class='span2 merge-div'></div>");
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
			            var li = $("<li></li>").attr('onclick', 'selectForMerge(this)');
			            var span = $("<span></span>").data({
			                            friendNumber: friendNumber,
			                            catId: catId,
			                            hash: hash
			                        })
			                        .text(name);
			            $(li).append(span);
			            $(ul).append(li);
			        });
			        
			        $(div).append(p);
			        $(div).append(ul).tsort();
			        $(slide).append(div);
			    });
			    
			    //Create list for merged names
			    var div = $("<div class='span2 merge-div'></div>");
			    var p = $("<p></p>").text("Merged");
			    var ul = $("<ul id='merged' class='merge-list'></ul>");
			    $(div).append(p);
			    $(div).append(ul);
			    $(slide).append(div);
			});
			
            Reveal.addEventListener( 'fragmentshown', function( event ) {
                if(event.fragment.dataset.show=="help-button"){
                    $('#help-img').css('display', 'block');
                }
            } );
            
            Reveal.addEventListener( 'strengthInit', function( event ) {
                var data = getApp();
                var names = [];
                $(data.friends).each(function(i, obj) {
                    names.push(obj.name);
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
            
            function error(type) {
              var mess;
              if (type=='STRENGTH') {
                mess="Please bring all of your friends into the circle";
              } 
              else if (type=='FOF') {
                mess="FOF ERROR";
              }
              else if (type=='NAMES') {
                mess="Are you sure you don't want to enter any names?";
              }
              else if (type=='LASTSEEN') {
                mess="Please select missing values.";
               } 
              $('#error').text(mess);
              $('#error').fadeIn('fast');
              var fade = setInterval(function() { 
                  $("#error").fadeOut('slow'); 
                  clearInterval(fade); }, 2000);
                }
                   
            function selectForMerge(e){
                $(e).children().toggleClass('selected');
            }
            
            function mergeFriends(){
                var selected = $('.selected');
                var m = $('#merged');
                if (selected.length > 1) {
                                  
                    var mList = [];
                    
                    $(selected).each(function (i, obj) {
                        var data = $(obj).data();
                        if ( data.hasOwnProperty('merged')) {
                            $(data.merged).each(function(i,d){
                                mList.push(d);
                            });
                        }
                        else{
                            var name = $(obj).text();
                            data.name = name;
                            mList.push(data);
                        }
                    });
                    
                    var newLi = $('<li></li>').attr('onclick', 'selectForMerge(this)');
                    var name = $(selected[0]).text();
                    var newSpan = $('<span></span>').text(name);
                    $(newSpan).data('merged', mList);
                    $(newSpan).on('dblclick', split);
                    newLi.append(newSpan);
                    m.append(newLi);
                    $(selected).parent().remove();
                }
                else {
                    return;
                }
                m.tsort();
            }

            function split(event) {
                var element = event.toElement;
                var merged = $(element).data('merged');
                $(merged).each(function (i, obj) {
                    var friendNumber = obj.friendNumber;
                    var name = obj.name;
                    var hash = obj.hash;
                    var catId = obj.catId;
                    var homeList = $("#{cat}-list".supplant({'cat':catId.split('_')[0]}));
                    var li = $('<li></li>').attr('onclick', 'selectForMerge(this)');
                    var span = $('<span></span>').data({
                                    friendNumber: friendNumber,
                                    catId: catId,
                                    name: name,
                                    hash: hash
                                })
                        .text(name);
                    li.append(span);
                    homeList.append(li);
                });
                $(event.target).parent().remove();
                $('.merge-list').tsort();
            }
            
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
            </script>
        
	</body>
</html>
