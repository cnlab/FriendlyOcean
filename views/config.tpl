<!DOCTYPE html>
<html lang="en">
    <head>
    <title>Friendly Island Config</title>

    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <script type="text/javascript" src="assets/js/jquery-1.10.1.min.js"></script>
    <script type="text/javascript" src="assets/js/bootstrap.min.js"></script>  

    <style>
        .control-group{
            margin-left: 20px;
        }
        .modal-body .lead{
            font-size: 16px;
        }
    </style>  
    </head>
    <body>
        <div class="container">
            <div class="page-header">
                <h1>Friendly Island Configuration Page</h1>
            </div>
            <div class="row">

                <div class="span7">
                    <form action="/configure" method="POST" enctype="multipart/form-data">
                        
                        <h4>
                            Please select a theme
                        </h4>
                        <div class="control-group">
                            <div class="controls">
                                <label class="radio">
                                    <input type="radio" name="theme" id="radio-ocean" value="ocean">
                                    Ocean
                                </label>
                                <label class="radio">
                                    <input type="radio" name="theme" id="radio-island" value="island" disabled>
                                    Island -- coming soon!
                                </label>
                                <label class="radio">
                                    <input type="radio" name="theme" id="radio-space" value="space"  disabled>
                                    Space -- coming soon!
                                </label>
                            </div>
                        </div>

                        <h4>
                            Please select which categories you would like to include. Think of these as channels of communication.
                        </h4>
                        <div class="control-group categories">
                            <div class="controls">
                                
                                <label class="checkbox">
                                    <input type="checkbox" name="family" id="check-family" data-toggle="collapse" data-target="#instructions-family" value=1>
                                    Family
                                </label>
                                <div class="control-group collapse instructions" id="instructions-family">
                                    <label class="control-label" for="textarea">These are default instructions for the Family category. You can change them by editing the text below. Note that a new paragraph is denoted by using a double pipe like so: ||</label>
                                    <label class="control-label" for="textarea">(<a href="#" class="preview-help">Preview Help</a>)</label>
                                    <div class="controls">
                                        <textarea rows="10" name="instructions-family" class="span6"></textarea>
                                    </div>
                                </div>

                                <label class="checkbox">
                                    <input type="checkbox" name="calling" id="check-calling" data-toggle="collapse" data-target="#instructions-calling" value=1>
                                    Calling
                                </label>
                                <div class="control-group collapse instructions" id="instructions-calling">
                                    <label class="control-label" for="textarea">These are default instructions for the Calling category. You can change them by editing the text below. Note that a new paragraph is denoted by using a double pipe like so: ||</label>
                                    <label class="control-label" for="textarea">(<a href="#" class="preview-help">Preview Help</a>)</label>
                                    <div class="controls">
                                        <textarea rows="10" name="instructions-calling" class="span6"></textarea>
                                    </div>
                                </div>

                                <label class="checkbox">
                                    <input type="checkbox" name="texting" id="check-texting" data-toggle="collapse" data-target="#instructions-texting"value=1>
                                    Texting
                                </label>
                                <div class="control-group collapse instructions" id="instructions-texting">
                                    <label class="control-label" for="textarea">These are default instructions for the Texting category. You can change them by editing the text below. Note that a new paragraph is denoted by using a double pipe like so: ||</label>
                                    <label class="control-label" for="textarea">(<a href="#" class="preview-help">Preview Help</a>)</label>
                                    <div class="controls">
                                        <textarea rows="10" name="instructions-texting" class="span6"></textarea>
                                    </div>
                                </div>

                                <label class="checkbox">
                                    <input type="checkbox" name="facebook" id="check-facebook" data-toggle="collapse" data-target="#instructions-facebook" value=1>
                                    Facebook
                                </label>
                                <div class="control-group collapse instructions" id="instructions-facebook">
                                    <label class="control-label" for="textarea">These are default instructions for the Facebook category. You can change them by editing the text below. Note that a new paragraph is denoted by using a double pipe like so: ||</label>
                                    <label class="control-label" for="textarea">(<a href="#" class="preview-help">Preview Help</a>)</label>
                                    <div class="controls">
                                        <textarea rows="10" name="instructions-facebook" class="span6"></textarea>
                                    </div>
                                </div>

                            </div>
                        </div>

                        <h4>
                            Please indicate how many friends you would like per category
                        </h4>
                        <div class="control-group">
                            <input class="span1" min="1" type="number" name="maxFriendsPerCategory" id="maxFriendsPerCategory">
                        </div>

                        <h4>
                            Please select which other components you would like to use
                        </h4>
                        <div class="control-group components">
                            <label class="checkbox">
                                <input type="checkbox" name="matching" id="check-matching" data-toggle="collapse" data-target="#instructions-matching" value=1>
                                Matching
                            </label>
                                <div class="control-group collapse instructions" id="instructions-matching">
                                    <label class="control-label" for="textarea">These are default instructions for the Matching component. You can change them by editing the text below. Note that a new paragraph is denoted by using a double pipe like so: ||</label>
                                    <label class="control-label" for="textarea">(<a href="#" class="preview-help">Preview Help</a>)</label>
                                    <div class="controls">
                                        <textarea rows="10" name="instructions-matching" class="span6"></textarea>
                                    </div>
                                </div>

                            <label class="checkbox">
                                <input type="checkbox" name="closeness" id="check-closeness" data-toggle="collapse" data-target="#instructions-closeness" value=1>
                                Closeness
                            </label>
                                <div class="control-group collapse instructions" id="instructions-closeness">
                                    <label class="control-label" for="textarea">These are default instructions for the Closeness component. You can change them by editing the text below. Note that a new paragraph is denoted by using a double pipe like so: ||</label>
                                    <label class="control-label" for="textarea">(<a href="#" class="preview-help">Preview Help</a>)</label>
                                    <div class="controls">
                                        <textarea rows="10" name="instructions-closeness" class="span6"></textarea>
                                    </div>
                                </div>

                            <label class="checkbox">
                                <input type="checkbox" name="circles" id="check-circles" data-toggle="collapse" data-target="#instructions-circles" value=1>
                                Social Circles
                            </label>
                                <div class="control-group collapse instructions" id="instructions-circles">
                                    <label class="control-label" for="textarea">These are default instructions for the Social Circles component. You can change them by editing the text below. Note that a new paragraph is denoted by using a double pipe like so: ||</label>
                                    <label class="control-label" for="textarea">(<a href="#" class="preview-help">Preview Help</a>)</label>
                                    <div class="controls">
                                        <textarea rows="10" name="instructions-circles" class="span6"></textarea>
                                    </div>
                                </div>

                            <label class="checkbox">
                                <input type="checkbox" name="friendOfFriend" id="check-friendOfFriend" data-toggle="collapse" data-target="#instructions-friendOfFriend" value=1>
                                Friend Linking
                            </label>
                                <div class="control-group collapse instructions" id="instructions-friendOfFriend">
                                    <label class="control-label" for="textarea">These are default instructions for the Friend Linking component. You can change them by editing the text below. Note that a new paragraph is denoted by using a double pipe like so: ||</label>
                                    <label class="control-label" for="textarea">(<a href="#" class="preview-help">Preview Help</a>)</label>
                                    <div class="controls">
                                        <textarea rows="10" class="span6" name="instructions-friendOfFriend"></textarea>
                                    </div>
                                </div>

                            <label class="checkbox">
                                <input type="checkbox" name="survey" id="check-survey" value=1 data-target="#survey-upload" data-toggle="collapse">
                                Surveying
                            </label>
                                <div class="control-group collapse instructions" id="survey-upload">
                                    <label class="control-label" for="filebutton">Upload a JSON file containing an object for each survey question you have. <a href="/surveys_example.json" target="_blank" id="survey-example">See an example</a></label>
                                    <div class="controls">
                                        <input id="surveys" name="surveys" class="input-file" type="file">
                                    </div>
                                </div>

                        </div>
<button class="btn btn-primary btn-large" type="submit">Submit</button>
                    </form>
                </div>

                <div class="span4">
                    <div class="well">
                        <h4>Instructions</h4>
                        <p>Use the form on the left to customize a version of the Friendly Island app. Check the boxes for each category and component you would like to include.</p>
                        <p>When you click the submit button, a zip file containg your <code>config.py</code> file, your appID, and some instructions on accessing your data will be downloaded. Place the <code>config.py</code> file in the root directory of the app (the same folder where you find <code>default_config.py</code>), overwriting any other instance of <code>config.py</code>.</p>
                        <p>Do not edit or modify <code>default_config.py</code> because it is the base class that <code>config.py</code> extends. If you want to save the original <code>config.py</code> file that ships with this app, simply rename it to something like <code>orig_config.py</code>.</p>
                    </div>
                    <div class="alert alert-error" style="display:none;">
                        <strong>Warning!</strong> It is recommended that you include the matching component when using 2 or more channels in order to prevent duplication.
                    </div>
                </div>
            </div>
    </div>

    <!--Begin help preview modal-->

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

    <!--/End help preview modal-->


    <script type="text/javascript">

        //Load default config from server
        jQuery.getJSON ("/get_config", function( config ){

            //Check radio button for theme
            $("#radio-" + config.theme).attr("checked", "checked");

            //Fill out instructions
            for( obj in config.categories){
                $("textarea[name='instructions-" + obj + "']").val(config['categories'][obj]['help'])
            };
            for( obj in config.components){
                $("textarea[name='instructions-" + obj + "']").val(config['components'][obj]['help'])
            };

            //Set Max friends
            $("#max-friends").val(config.maxFriendsPerCategory);

        });

        //Bind preview links to help modal
        $("a.preview-help").click( function( e ){
            e.stopPropagation();
            e.preventDefault();
            var instr = $(this).parent().next().children("textarea").val().split("||");
            var mb = $("#help").find(".modal-body");
            $(mb).children().remove();
            $(instr).each( function( i, obj ){
                var p = $("<p class='lead'></p>");
                $(p).text(obj);
                $(mb).append(p);
           });
            $("#help").modal("show");
        });

        //Require matching if 2 or more catergories are selected
        $(".categories input[type='checkbox']").change( function( e ){
            if( $(".categories input[type='checkbox']:checked").length >= 2 && !$("#instructions-matching").hasClass("in") ){
                $("#check-matching").click();
                $(".alert").toggle();
            }else if( $(".categories input[type='checkbox']:checked").length < 2 && $("#instructions-matching").hasClass("in") ){
                $("#check-matching").click();
                $(".alert").toggle();
            }
        });


    </script>
    </body>
</html>