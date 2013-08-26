<!doctype html>
<html lang="en">

<head>
  <meta charset="utf-8">

  <title></title>

  <meta name="apple-mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />

  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

  <link rel="stylesheet" href="assets/css/bootstrap.min.css">
  <link rel="stylesheet" href="assets/css/reveal.css">
  <link rel="stylesheet" href="assets/css/theme/{{ theme }}.css" id="theme">
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
            <div class="reveal" data-state>

             <!-- Any section element inside of this container is displayed as a slide -->
             <div class="slides">

                <section id="title" data-background="assets/img/backgrounds/title.png">
                    <div class="row">
                        <div class="span5">
                            <h1>Friendly<br/><span class="island-type-caps"></span></h1>
                            <p>Click the <span class="arrow-type"></span> to begin!</p>
                        </div>
                    </div>
                </section>
                
                <section id="authorize">
                    <div class="row slide-header">
                        <h2>Facebook Authorization</h2>
                    </div>
                    <div class="row">
                        <div class="span12">
                            <p>This application would like to access your Facebook account in order to grab the names of friends you've interacted with in the past week. Once you complete the game, you will be logged out of Facebook and your friend's names will be anonymized. Alternatively, you can enter them manually... but that's just more work for you.</p> 
                        </div>
                        <div class="span12">
                            <p>
                                <button class="btn btn-primary btn-large" onclick="yesSNS();">Log in</button>
                            </p>
                            <h5>
                                <a href="javascript:void(0);" onclick="noSNS();">Enter names manually</a>
                            </h5>
                        </div>                
                    </div>
                </section>
                
                <section id="congratulations">
                    <div class="row slide-header">
                        <h2>Congratulations!</h2>
                    </div>
                    <div class="row">
                        <p>
                            You have just been awarded an empty tropical <span class="island-type"></span> for you and all of your friends and family.
                        </p>
                        <p class="fragment">
                            This study is trying to understand how individuals’ <span class="island-type-plural"></span> (or social networks) are different from one another in the 21st Century.
                        </p>
                    </div>
                </section>
                
                <section id="objective" data-transition="none">
                        <div class="row slide-header">
                            <h2>Your Goal</h2>
                        </div>
                        <div class="row">
                            <p>
                                Populate your <span class="island-type"></span> with everyone in your social network that you talk to regularly or know personally.
                            </p>
                        </div>
                    <div class="row">
                        <p>Before you get started...</p>
                        <p>
                            <span class="inline-help">Name your <span class="island-type"></span> </span>
                            <input class="input-large" name="island-name" type="text"/>
                            <span class="inline-help"> and click the <span class="arrow-type"></span>.</span>
                        </p>
                    </div>                
                </section>
                
                <section class="instructions" data-transition="none">
                    <div class="row slide-header">
                        <h2>Instructions</h2>
                    </div>
                    <div class="row">
                        <p>Now, you need to bring over some people to join you on <span class='islandName'></span>.</p>
                        <p>Please read the following instructions carefully before beginning the game...</p>
                    </div>
                </section>
                
                <section class="instructions" data-transition="none">
                    <div class="row slide-header">
                        <h2>Instructions</h2>
                    </div>
                    <div class="row">
                        <p>During the game, you will be asked to enter the first name and initial (or a nickname like “Mom” or “Matt from School”) of your family, friends, and acquaintances who you interact with on a normal basis and know personally.</p>
                        <p>The reason to enter names with initials (or a nickname) is so that you can keep track of which person is which throughout the game.</p>
                    </div>
                </section>
                
                <section class="instructions" data-transition="none">
                    <div class="row slide-header">
                        <h2>Instructions</h2>
                    </div>
                    <div class="row">
                        <p>On <span class='islandName'></span>, each of your personal relationships will each get their own piece of the <span class="island-type"></span>.</p>
                        <p>In order for your to build the most complete <span class="island-type"></span> civilization, you will bring people over in six different boats.</p>
                        <div class="span5 offset2">
                            <ol>
                                <li>Family</li>
                                <li>Calling</li>
                                <li>Texting</li>
                                <li>Facebook</li>
                            </ol>
                        </div>
                    </div>
                </section>
                
                <section class="instructions" data-transition="none">
                    <div class="row slide-header">
                        <h2>Instructions</h2>
                    </div>
                    <div class="row">
                        <p>After you have transported everyone to <span class='islandName'></span>, you will then decide how much land they get based on how close you are to them.</p>
                        <p>Finally, you will decide who will live on the same part of the <span class="island-type"></span> as other individuals based on who knows who.</p>
                    </div>
                </section>
                
                <section class="instructions" data-transition="none">
                    <div class="row slide-header">
                        <h2>Three more important things</h2>
                    </div>
                    <div class="row fragment">
                        <p><strong>1&#41; Privacy</strong></p>
                        <p>After you have finished the game, we will remove <span class="underline">all</span> of your friends’ names/nicknames automatically so that your social network is <span class="underline">completely anonymous</span>.</p>
                    </div>
                    <div class="row fragment" data-show="help-button">
                        <p><strong>2&#41; Help</strong></p>
                        <p>You'll receive instructions along the way. If you ever need to revisit them, you can click the question mark in the upper left-hand corner. Give it a try right now!</p>
                    </div>
                    <div class="row fragment">
                        <p><strong>3&#41; Have fun!</strong></p>
                    </div>
                </section>
                
                <section id="family" data-category="family" data-show="help" class="category add-names">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>Family - <input class="friend-input" name="family-friend-input" type="text" placeholder="Type a name and press Enter"/></h2>
                        </div>
                        <div class="row">
                            <ul class="friend-list">
                            </ul>
                        </div>
                    </div>
                </section>
                
                <section id="calling" data-category="calling" data-show="help" class="category add-names">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>Calling - <input class="friend-input" name="calling-friend-input" type="text" placeholder="Type a name and press Enter"/></h2>
                        </div>
                        <div class="row">
                            <ul class="friend-list">
                            </ul>
                        </div>
                    </div>
                </section>
                
                <section id="texting" data-category="texting" data-show="help" class="category add-names">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>Texting - <input class="friend-input" name="texting-friend-input" type="text" placeholder="Type a name and press Enter"/></h2>
                        </div>
                        <div class="row">
                            <ul class="friend-list">
                            </ul>
                        </div>
                    </div>
                </section>
                
                <section id="facebook" data-category="facebook" data-show="help" class="category add-names sns">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>Facebook</h2>
                        </div>
                        <div class="row list-row">
                            <ul class="friend-list">
                            </ul>
                        </div>
                    </div>
                </section>
                
                <section id="merge" data-state="merge" data-category="merge" data-show="help" class="merge no-text-select">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>Merge Duplicates and Disembark</h2>
                        </div>
                        <div class="row lists-row">
                            <div class="span4 merge-lists-left">
                            </div>
                            <div class="span3 merge-lists-center">
                                                           
                            </div>
                            <div class="span3 merge-lists-right">
                            </div>                        
                        </div>
                    </div>
                </section>
                
                <section id="closeness" data-category="closeness" data-show="help" data-state="strengthInit" class="no-text-select">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>Closeness</h2>
                        </div>
                        <div class="row chart" id="closenessChart">
                            <!--Leave this space empty. It is where the svg canvas is inserted when strength.js is initiated-->
                        </div>
                    </div>
                </section>
                
                <section id="lastSeen" data-state="lastSeen" data-category="lastSeen" data-show="help">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>When did you last see everyone?</h2>
                        </div>
                        <table id="lastSeenTable" class="table table-striped">
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
                
                <section id="circles" data-category="circles" data-state="circles" data-show="help">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>Social Circles</h2>
                        </div>
                        <div class="row"><p>Your Friends</p></div>
                        <div id="names-list" class="row circles-row">
                            <!--Leave this space empty. Data is dynamically generated.-->
                        </div>
                        <div class="row">
                            <p>Your Circles 
                                <input id="circle-input" class="input-xlarge" type="text" placeholder="Type a name for a circle and press Enter"/>
                            </p>
                        </div>
                        <div id="circles-list" class="row circles-row">
                            <!--Leave this space empty. Data is dynamically generated.-->
                        </div>                        
                    </div>
                </section>
                
                <section id="friendOfFriend" data-category="friendOfFriend" data-state="friendOfFriend" data-show="help" class="no-text-select">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>Friends of friends: Who knows <span id="currentFOF"></span>? <button id="next-friend" class="btn btn-primary">Next Friend <i class="icon-forward icon-white"></i></button></h2>
                        </div>
                        <div class="row">
                            <div class="span4" id="node-list">
                            </div>
                            <div class="span7" id="friendGraph">
                                <!--Leave this space empty. Graph is genereated by fof object.-->
                            </div>

                        </div>
                    </div>
                </section>
                
                <section id="end" data-category="end" data-state="end" class="no-text-select">
                    <div class="container" id="myNetwork">
                        <div class="row"> 
                            <h2>Welcome to <span class='islandName'></span>!</h2>
                        </div>
                    </div>
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

    <!--Error div-->
    <div id="error"></div>

    <!--Javascripts-->
    <script src="assets/js/jquery-1.10.1.min.js"></script>
    <script src="assets/js/jquery.tinysort.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/reveal.js"></script>
    <script src="assets/js/d3.v2.js"></script>
    <script src="assets/friendly/friendly.js"></script>
    <script src="assets/friendly/strength.js"></script>
    <script src="assets/js/jquery.dataTables.min.js"></script>
    <script src="assets/friendly/fof.js"></script>
    <script src="assets/friendly/myNetwork.js"></script>

    <script type="text/javascript">

    //Do these things on load
    $(document).attr('title', 'Friendly {type}'.supplant({"type": Friendly.config.islandType.capitalize()}));
    var pID = "{{ pID }}";
    Friendly.appID = "{{ appID }}";
    $(".island-type").text(Friendly.config.islandType);
    $(".island-type-plural").text(Friendly.config.islandType+"s");
    $(".island-type-caps").text(Friendly.config.islandType.capitalize());
    $(".arrow-type").text(Friendly.config.arrowType);
    $("<img></img>").attr('src', 'assets/img/elements/{type}.png'.supplant({"type": Friendly.config.arrowType})).appendTo("#next-arrow");
    ////

    $('#help').on('hidden', function(){
        $(Reveal.getCurrentSlide()).find('input').focus();
    });

    $('#next-friend').click(function( event ){
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
                
                //Login to FB using SDK
                FB.login(

                    //Callback for FB.login()
                    function(response){

                        $(span).html('<h4>Thanks! We\'re all set here. Click the arrow to continue.</h4>');
                        
                        //Check that we're connected
                        if(response.status === 'connected'){

                            //Grab the access token and send it to the server
                            var access_token = FB.getAccessToken();
                            $.post('/get_interactions',
                                   {access_token:access_token},
                                   function(response){
                                    var data = JSON.parse(response);
                                    if( data.response === 'false' ) {
                                        noSNS('<h4>Oops! Looks like something went wrong. You\'ll have to enter the names manually. Click the arrow to continue</h4>');
                                    }
                                    else if( data.fbFriends.friends.length < 1 ){
                                        noSNS('<h4>Thanks! We\'re all set here. Click the arrow to continue.</h4>');
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
    var input = $('<input class="friend-input" name="{category}-friend-input" type="text" placeholder="Type a name and press Enter"/>'.supplant({'category': $(slide).data('category')}));
    $(input).keypress(friendInputHandler);
    var header = $(slide).find('.slide-header h2');
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
                $('.islandName').text(islandName);
                Friendly.islandName = islandName;
            }
            else {
                error("ISLANDNAME");
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
                //disembark(null, null, true);
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
    
    //Run DataTable.js on lastSeenTable
     lst = $('#lastSeenTable').dataTable( {
        "bInfo":false,
        "bDestroy":true,
        "iDisplayLength": 10,
        "sPaginationType":"scrolling",
        "bSort":false,
        'bFilter':false,
        "bLengthChange":false,
        "fnDrawCallback": function(){
            if( Friendly.friends.length <= 10 ){
                $("#lastSeenTable_paginate").css("display", "none")
            }
            else{
                $("#lastSeenTable_paginate button").addClass("btn btn-primary");
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
    var left = $('#merge .merge-lists-left'),
          center = $("#merge .merge-lists-center"),
          right = $('#merge .merge-lists-right');

                //Build friend lists
                createFriendLists( left );

        //Create list for merged names
        var div = $("<div class='merge-div'></div>");
        var bM = $("<button></button>").addClass("btn btn-primary btn-block")
                                                                            .on("click", mergeFriends)
                                                                            .text("Merge");
        var ul = $("<ul id='merged' class='merge-list'></ul>");
        $(div).append(bM);
        $(div).append(ul);
        $(center).append(div);

                 //Create list for the island/dock/whatevs
                 div = $("<div class='merge-div'></div>");
                 bD = $("<button></button>").addClass("btn btn-primary btn-block")
                                                                      .on("click", disembarkCheck)
                                                                      .text("Disembark");
                 ul = $("<ul id='merged' class='merge-list'></ul>");
                $(div).append(bD);
                $(div).append(ul);
                $(right).append(div);
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
    $(".circle-selected").removeClass('circle-selected')
                                     .css({
                                        'box-shadow': 'none',
                                        '-moz-box-shadow': 'none',
                                        '-webkit-box-shadow': 'none',
                                        'border': '1px solid #cccccc'
                                     });
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
    $(circle).css({
        'box-shadow': '0px 0px 10px 5px {color}'.supplant({'color': clr.replace(/,([\s\S]{1,3})\)/, ",.75)")}),
        '-moz-box-shadow': '0px 0px 10px 5px {color}'.supplant({'color': clr.replace(/,([\s\S]{1,3})\)/, ",.75)")}),
        '-webkit-box-shadow': '0px 0px 10px 5px {color}'.supplant({'color': clr.replace(/,([\s\S]{1,3})\)/, ",.75)")}),
        'border': '1px solid {color}'.supplant({'color': clr})
    })
    .toggleClass('circle-selected');
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
    if (type=='STRENGTH') {
        mess="Please bring all of your friends into the circle";
    }
    else if (type=='CIRCLEDUP') {
        mess="There is already a group with that title. Please choose a different title.";
    }
    else if (type=='CIRCLETITLE') {
        mess="Please pick a title for this circle.";
    }
    else if (type=='CIRCLESNAMES') {
        mess="A group needs at least 2 people.";
    }
    else if (type=='FOF') {
        mess="FOF ERROR";
    }
    else if (type=='ISLANDNAME') {
        mess="Please enter a name.";
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

function select(e){
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

        var newLi = $('<li></li>').attr('onclick', 'select(this)');
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
    $(m).children('li').tsort();
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
        var li = $('<li></li>').attr('onclick', 'select(this)');
        var span = $('<span class="no-text-select"></span>').data({
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
    $('.merge-list li').tsort();
}

function createFriendLists(targetElement) {

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
                     var span = $("<span class='no-text-select'></span>").data({
                         friendNumber: friendNumber,
                         catId: catId,
                         hash: hash
                     })
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
