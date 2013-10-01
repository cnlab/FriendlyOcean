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
  <link rel="stylesheet" href="assets/css/theme/{{ config['theme'] }}.css" id="theme">
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
              channelUrl : 'channel',
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
                <a data-toggle="modal" href="#help"><img src="assets/img/ocean/elements/help.png" /></a>
            </div>
            <div id="next-arrow"></div>
            <div class="reveal" data-state>

             <!-- Any section element inside of this container is displayed as a slide -->
             <div class="slides">

                <section id="title" data-background="assets/img/ocean/backgrounds/title.png">
                    <div class="row">
                        <h1>Friendly</h1>
                    </div>
                    <div class="row">
                        <h1 class="island-type-caps"></span></h1>
                    </div>
                    <div class="row">
                        <p>Click the <span class="arrow-type"></span> to begin!</p>
                    </div>
                </section>
                
                %for i, section in enumerate(config['categories']):
                %if section['id'] is 'facebook':
                <section id="authorize" data-category="authorize" data-background="assets/img/ocean/backgrounds/auth.png" data-progress="Intro">
                    <div class="row slide-header">
                        <h2>Facebook Authorization</h2>
                    </div>
                    <div class="row">
                            <p>This application would like to access your Facebook account in order to grab the names of friends you've interacted with in the past week. Once you complete the game, you will be logged out of Facebook and your friend's names will be anonymized. Alternatively, you can enter them manually... but that's just more work for you.</p> 
                    </div>
                    <div class="row auth-btns">
                        <div class="btn-group" data-toggle="buttons-radio">
                            <ul class="inline">
                                <li><button id="auth-yes" type="button" class="btn btn-large btn-success" onclick="yesSNS();">Log in</button></li>
                                <li><button id="auth-no" type="button" class="btn" onclick="noSNS();">No thanks</button></li>
                            </ul>
                        </div>
                    </div>       
                </section>
                %end
                %end
                
                <section id="congratulations" class="instructions" data-progress="Intro" data-background="assets/img/ocean/backgrounds/instr1.png">
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
                
                <section id="objective" class="instructions" data-category="objective" data-progress="Intro" data-transition="none" data-background="assets/img/ocean/backgrounds/instr2.png">
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
                
                <section class="instructions" data-progress="Intro" data-transition="none" data-background="assets/img/ocean/backgrounds/instr3.png">
                    <div class="row slide-header">
                        <h2>Instructions</h2>
                    </div>
                    <div class="row">
                        <p>Now, you need to bring over some people to join you.</p>
                        <p>Please read the following instructions carefully before beginning the game...</p>
                    </div>
                </section>
                
                <section class="instructions" data-progress="Intro" data-transition="none" data-background="assets/img/ocean/backgrounds/instr4.png">
                    <div class="row slide-header">
                        <h2>Instructions</h2>
                    </div>
                    <div class="row">
                        <p>During the game, you will be asked to enter the names of your family, friends, and acquaintances who you interact with on a normal basis and know personally.</p>
                    </div>
                </section>
                
                <section class="instructions" data-progress="Intro" data-transition="none" data-background="assets/img/ocean/backgrounds/instr5.png">
                    <div class="row slide-header">
                        <h2>Instructions</h2>
                    </div>
                    <div class="row">
                        <p>On <span class='island-name'></span>, each of your personal relationships will get its own piece of the <span class="island-type"></span>.</p>
                        <p>In order for your to build the most complete <span class="island-type"></span> civilization, you will bring people over in four different boats.</p>
                        <div class="span5 offset2">
                            <ol>
                                %for cat in config['categories']:
                                <li>{{ cat['id'].title() }}</li>
                                %end
                            </ol>
                        </div>
                    </div>
                </section>
                
                <section class="instructions" data-progress="Intro" data-transition="none" data-background="assets/img/ocean/backgrounds/instr6.png">
                    <div class="row slide-header">
                        <h2>Instructions</h2>
                    </div>
                    <div class="row">
                        <p>After you have transported everyone to <span class='island-name'></span>, you will then decide how much space they get based on how close you are to them.</p>
                        <p>Finally, you will decide where each person will be located based upon who knows who.</p>
                    </div>
                </section>
                
                <section class="instructions" data-progress="Intro" data-transition="none" data-background="assets/img/ocean/backgrounds/instr7.png">
                    <div class="row slide-header">
                        <h2>Three more important things</h2>
                    </div>
                    <div class="row">
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
                
                %for i, section in enumerate(config['categories']):
                <section id="{{ section['id'] }}" data-category="{{ section['id'] }}" data-progress="Adding" data-show="help" class="category add-names" data-background="assets/img/ocean/backgrounds/{{ section['id'] }}.png">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>{{ section['title'] }}
                                %if section['id'] is not 'facebook':
                                 - <input class="friend-input" name="{{ section['id'] }}-friend-input" type="text" placeholder="Type a name and press Enter"/>
                                %end
                            </h2>
                        </div>
                        <div class="row">
                            <ul class="friend-list">
                            </ul>
                        </div>
                    </div>
                </section>
                %end

                %for n, section in enumerate(config['components']):
                %if section['id'] is 'matching':
                <section id="matching" data-state="matching" data-progress="Matching" data-category="matching" data-show="help" class="matching" data-background="assets/img/ocean/backgrounds/matching.png">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>Find Matches and Disembark</h2>
                        </div>
                        <div class="row slide-header">
                            <h3>Please highlight each instance of <span class="current-merge-name"></span> on this page.
                                <button class="btn btn-primary btn-merge" id="next-merge">Next Friend <i class="icon-forward icon-white"></i></button>
                            </h3>
                        </div>
                        <div class="row lists-row">
                            <!--Leave this space empty. Lists are dynamically generated-->
                        </div>
                        <div class="row div-row">
                        </div>
                        <div class="row merge-row shore">
                            <ul id='merged' class='merge-list'></ul>
                        </div>
                    </div>
                </section>

                %elif section['id'] is 'closeness':
                <section id="closeness" data-category="closeness" data-progress="Spacing" data-show="help" data-state="strengthInit" data-background="assets/img/ocean/backgrounds/closeness.png">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>Closeness</h2>
                        </div>
                        <div class="row chart" id="closenessChart">
                            <!--Leave this space empty. It is where the svg canvas is inserted when strength.js is initiated-->
                        </div>
                    </div>
                </section>

                %elif section['id'] is 'survey':
                %for i, obj in enumerate( section['surveys'] ):
                <section id="{{ obj['key'] }}" class="survey" data-state="survey" data-surveyindex="{{ i }}" data-progress="Spacing" data-category="survey" data-show="help" data-background="assets/img/ocean/backgrounds/survey.png">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>{{ obj['question'] }}</h2>
                        </div>
                        <table id="{{ obj['key'] }}-table" class="table table-striped survey-table">
                            <thead>
                                <tr>
                                    <th></th>
                                    %for option in obj['responses']:
                                    <th>{{ option['text'] }}</th>
                                    %end
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </section>
                %end

                %elif section['id'] is 'circles':
                <section id="circles" data-category="circles" data-state="circles" data-progress="Grouping" data-show="help" data-background="assets/img/ocean/backgrounds/circles.png">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>Groups</h2>
                        </div>
                        <div class="row"><p>Your Friends</p></div>
                        <div id="names-list" class="row circles-row">
                            <!--Leave this space empty. Data is dynamically generated.-->
                        </div>
                        <div class="row">
                            <p>Your Groups 
                                <input id="circle-input" class="input-xlarge" type="text" placeholder="Type a name for a group and press Enter"/>
                            </p>
                        </div>
                        <div id="circles-list" class="row circles-row">
                            <!--Leave this space empty. Data is dynamically generated.-->
                        </div>                        
                    </div>
                </section>

                %elif section['id'] is 'friendOfFriend':
                <section id="friendOfFriend" data-category="friendOfFriend" data-progress="Connecting" data-state="friendOfFriend" data-show="help" data-background="assets/img/ocean/backgrounds/friendOfFriend.png">
                    <div class="container">
                        <div class="row slide-header">
                            <h2>Friends of friends: Who knows <span id="currentFOF"></span>? <button id="next-fof" class="btn btn-primary">Next Friend <i class="icon-forward icon-white"></i></button></h2>
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
                %end
                %end

                <section id="end" data-category="end" data-state="end" data-progress="End" data-background="assets/img/ocean/backgrounds/end.png">
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
    <script src="assets/js/jquery-1.10.2.min.js"></script>
    <script src="assets/js/jquery.tinysort.min.js"></script>
    <script src="assets/js/bootstrap.min.js"></script>
    <script src="assets/js/reveal.js"></script>
    <script src="assets/js/d3.v3.min.js"></script>
    <script src="assets/friendly/friendly.js"></script>
    <script src="assets/friendly/strength.js"></script>
    <script src="assets/js/jquery.dataTables.min.js"></script>
    <script src="assets/friendly/fof.js"></script>
    <script src="assets/friendly/merger.js"></script>
    <script src="assets/friendly/myNetwork.js"></script>

    <script type="text/javascript">
        
        //Participant ID. Pulled from pID URL parameter. Otherwise defaults to "anon"
        var pID = "{{ pID }}";

        //instructions object to map instructions:   {section: [help]}
        var instructions = {};

        //surveys object to map surveys and responses: { id: [responses]}
        var surveys = {};

        //Load the app
        jQuery.getJSON("/load_config", {appID: "{{ config['appID'] }}"}, function( response ){
            
            //Set config to Friendly object
            Friendly.config = response;

            $(document).attr('title', 'Friendly {type}'.supplant({"type": Friendly.config.theme.capitalize()}));
            $(".island-type").text(Friendly.config.theme);
            $(".island-type-plural").text(Friendly.config.theme+"s");
            $(".island-type-caps").text(Friendly.config.theme.capitalize());
            $(".arrow-type").text(Friendly.config.arrowType);
            $("<img></img>").attr('src', 'assets/img/ocean/elements/{type}.png'.supplant({"type": Friendly.config.arrowType})).appendTo("#next-arrow");
            
            //Check for app in local storage
            if( getApp() ){
                Friendly = getApp();
                if( Friendly.fbFriends.friends && Friendly.fbFriends.friends.length > 0 ){
                    fillFBList(Friendly.fbFriends.friends);
                }else{
                    noSNS();
                }
                //Populate the instructions object and the surveys object
                $(Friendly.config.categories).each(function( i, obj ){
                    instructions[obj.id] = obj.help;
                });
                
                $(Friendly.config.components).each(function( i, obj ){
                    instructions[obj.id] = obj.help;
                    if( obj.id === 'survey' ){
                        $( obj.surveys ).each(function( x, surv ){
                            surveys[surv.key] = {
                                questions: surv.questions,
                                key: surv.key,
                                responses: surv.responses
                            };
                        });
                    }
                });
                Reveal.slide(Friendly.slide);
                $('#help-img').css('display', 'block');
                $(".island-name").text(Friendly.islandName);
            }else{

                //Populate the instructions object and the surveys object
                $(Friendly.config.categories).each(function( i, obj ){
                    instructions[obj.id] = obj.help;
                });
                
                $(Friendly.config.components).each(function( i, obj ){
                    instructions[obj.id] = obj.help;
                    if( obj.id === 'survey' ){
                        $( obj.surveys ).each(function( x, surv ){
                            surveys[surv.key] = {
                                questions: surv.questions,
                                key: surv.key,
                                responses: surv.responses
                            };
                        });
                    }
                });
            }
        });

    </script>
</body>
</html>