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

<body class="no-text-select">

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

            <div id="help-img">
                <a data-toggle="modal" href="#help"><img src="assets/img/elements/help.png" /></a>
            </div>
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
                
                <section id="authorize" data-background="assets/img/backgrounds/auth.png">
                    <div class="row slide-header">
                        <h2>Facebook Authorization</h2>
                    </div>
                    <div class="row">
                            <p>This application would like to access your Facebook account in order to grab the names of friends you've interacted with in the past week. Once you complete the game, you will be logged out of Facebook and your friend's names will be anonymized. Alternatively, you can enter them manually... but that's just more work for you.</p> 
                    </div>
                    <div class="span12">
                        <div class="btn-group" data-toggle="buttons-radio">
                            <ul class="inline">
                                <li><button type="button" class="btn btn-large btn-success" onclick="yesSNS();">Log in</button></li>
                                <li><button type="button" class="btn" onclick="noSNS();">No thanks</button></li>
                            </ul>
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
                        <p>Now, you need to bring over some people to join you on <span class='island-name'></span>.</p>
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
                        <p>On <span class='island-name'></span>, each of your personal relationships will each get their own piece of the <span class="island-type"></span>.</p>
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
                        <p>After you have transported everyone to <span class='island-name'></span>, you will then decide how much land they get based on how close you are to them.</p>
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
                            <h2>Welcome to <span class='island-name'></span>!</h2>
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
        
        //Check for app in local storage
        if( getApp() ){
            Friendly = getApp();
            if( Friendly.config.categories.facebook.show && Friendly.sns && Friendly.fbFriends.friends.length > 0 ){
                fillFBList(Friendly.fbFriends.friends);
            }else if( Friendly.config.categories.facebook.show ){
                noSNS();
            }
            Reveal.slide(Friendly.slide);
            $('#help-img').css('display', 'block');
            $(".island-name").text(Friendly.islandName);
        }

    </script>
</body>
</html>