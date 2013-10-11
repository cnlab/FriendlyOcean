    <!DOCTYPE html>
    <html lang="en">
        <head>
        <title>Friendly Island Config</title>

        <meta name="apple-mobile-web-app-capable" content="yes" />
        <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

        <link rel="stylesheet" href="assets/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/bootstrap-fileupload.min.css">
        <link rel="stylesheet" href="assets/css/vex.css" />
        <link rel="stylesheet" href="assets/css/vex-theme-wireframe.css" />

        <style>
            ul[id$="categories"]{
                min-height: 215px;
            }
            ul[id$="components"]{
                min-height: 270px;
            }
            ul[id^="selected"]{
                background: rgba(108, 161, 116, 0.7);
                -webkit-box-shadow:  0px 0px 0px 4px #6c9773;
                box-shadow:  0px 0px 0px 4px #6c9773;
            }
            ul[id^="available"]{
                background: rgba(241, 241, 241, 1);
                -webkit-box-shadow:  0px 0px 0px 4px rgba(170, 170, 170, 1);
                box-shadow:  0px 0px 0px 4px rgba(170, 170, 170, 1);
            }
            ul[id^="selected"]>li,
            ul[id^="available"]>li{
                border-radius: 4px;
                -moz-border-radius: 4px;
                -webkit-border-radius: 4px;
                color: #f1f1f1;
                font-family: Arial, Helvetica, Sans-Serif;
                text-shadow: 1px 1px 1px #666;
                font-size: 18px;
                clear: both;
                padding: 8px 0;
                text-align: center;
                -moz-box-shadow: 0 1px 3px #111;
                -webkit-box-shadow: 0 1px 3px #111;
                box-shadow: 0 1px 3px #111;
                cursor: pointer;
            }
            ul[id^="available"]>li,
            ul[id^="selected"]>li:hover{
                border: 1px solid #929fa5;
                background: #acb6bb; /* old browsers */
                background: -moz-linear-gradient(top, #acb6bb 0%, #85959c 100%); /* firefox */
                background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#acb6bb), color-stop(100%,#85959c)); /* webkit */
                filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#acb6bb', endColorstr='#85959c',GradientType=0 ); /* ie */
            }
            ul[id^="selected"]>li,
            ul[id^="available"]>li:hover{
                border: 1px solid #d39410;
                background: #e9a412; /* old browsers */
                background: -moz-linear-gradient(top, #e9a412 0%, #d39410 100%); /* firefox */
                background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#e9a412), color-stop(100%,#d39410)); /* webkit */
                filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#e9a412', endColorstr='#d39410',GradientType=0 ); /* ie */
            } 
            ul{
                list-style: none;
                margin: 10px auto 50px auto;
                border-radius: 10px;
                padding: 40px;
            }
            ul>li:not(:last-child){
                margin: 0px 0px 20px 0px;
            }
            .button-div{
                text-align:center;
                margin: 20px 0px 40px 0px;
                border-top: 1px solid #cccccc;
                padding: 20px 0px;
            }
            #survey-upload{
                display:none;
            }

        </style>  
        </head>
        <body>
            <div class="container">
                <div class="page-header">
                    <h1>Friendly Island Configuration Page</h1>
                </div>

                <div class="row">
                    <div class="span12">
                    <h2>Instructions</h2>
                    <p>Woo!</p>
                    </div>
                </div>

                <div class="row">
                    <div class="span12">
                        <h3>Categories</h3>
                        <p>The items on the left are the available categories. Please click each category to add it to or remove it from the list on the right. You can reorder your list of selected categories by dragging them or by clicking the "Random" link.</p>
                        <p><strong>Note: </strong>If you select 2 or more categories, the "Matching" component is included automatically to avoid duplication across categories.</p>
                        <div class="span3 offset2">
                            <h4>Available Categories</h4>
                            <ul id="available-categories">
                                <li id="family">Family</li>
                                <li id="calling">Calling</li>
                                <li id="texting">Texting</li>
                                <li id="facebook">Facebook</li>
                            </ul>
                        </div>

                        <div class="span3 offset1">
                            <h4>Selected Categories <small>(<a href="#" id="randomize">Random</a>)</small></h4>
                            <ul id="selected-categories">
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="span12">
                        <h3>Components</h3>
                        <p>The items on the left are the available components. Please click each component to add it to or remove it from the list on the right. These items cannot be reorderd at this time.</p>
                        <div class="span3 offset2">
                            <h4>Available Components</h4>
                            <ul id="available-components">
                                <li id="matching" data-order="1">Matching</li>
                                <li id="closeness" data-order="2">Closeness</li>
                                <li id="survey" data-order="3">Survey</li>
                                <li id="circles" data-order="4">Circles</li>
                                <li id="friendOfFriend" data-order="5">Linking</li>
                            </ul>
                        </div>
                        <div class="span3 offset1">
                            <h4>Selected Components</h4>
                            <ul id="selected-components">
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="span4">
                        <h3>
                            Choose a theme
                        </h3>
                        
                        <div class="control-group">
                            <div class="controls">
                                <label class="radio">
                                    <input type="radio" name="theme" id="radio-ocean" value="ocean" checked>
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
                    </div>
                    
                    <div class="span4">
                        <h3>
                            Max friends per category
                        </h3>
                        <p>Defaults to 20</p>
                        <div class="control-group">
                            <input class="span1" min="1" type="number" name="maxFriendsPerCategory" id="maxFriendsPerCategory">
                        </div>
                    </div>

                    <div class="span4" id="survey-upload">
                        <h3>
                            Upload Surveys
                        </h3>
                        <p>Please upload a JSON file containing an object for each survey. ( <a href="assets/friendly/surveys_example.json" target="_blank">example</a> | <a href="assets/friendly/surveys_template.json" target="_blank">template</a> )
                        <div class="fileupload fileupload-new" data-provides="fileupload">
                            <span class="btn btn-file">
                                <span class="fileupload-new">Select file</span>
                                <span class="fileupload-exists">Change</span><input type="file" name="survey-file">
                            </span>
                            <span class="fileupload-preview"></span>
                            <a href="#" class="close fileupload-exists" data-dismiss="fileupload" style="float: none">×</a>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="span4" id="id-div">
                        <h3>
                            App ID <small>optional</small>
                        </h3>
                        <p>Do you have a unique ID in mind for this configuration? If not, we'll generate one for you.</p>
                        <div class="control-group">
                            <div class="controls">
                                <input class="span2" type="text" name="appID" id="appID">
                            </div>
                        </div>
                    </div>
                    <div class="span5">
                        <h3>
                            Description <small>optional</small>
                        </h3>
                        <p>A brief description to remind you about this configuration.</p>
                        <div class="control-group">
                            <div class="controls">
                                <textarea name="description" id="description" rows="5" class="span5"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="button-div">
                        <button type="button" class="btn btn-primary btn-large" id="submit">Submit</button>
                    </div>
                </div>
        </div>

        <!--Error div-->
        <div id="dialog" title="Oops!" style="display:none;">
        </div>
        
        <!--Other people's things-->
        <script type="text/javascript" src="assets/js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="assets/js/jquery-ui.min.js"></script>
        <script type="text/javascript" src="assets/js/jquery.tinysort.min.js"></script>
        <script type="text/javascript" src="assets/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="assets/js/bootstrap-fileupload.min.js"></script>
        <script type="text/javascript" src="assets/js/vex.combined.min.js"></script>
        <script>vex.defaultOptions.className = 'vex-theme-wireframe';</script>
    
        <!--Our thing-->
        <script type="text/javascript">
            
            //Initialized dragging and dropping on the Available Categories list
            $( "#selected-categories" ).sortable();

            //Bind random sorting to element
            $("a#randomize").click(function( e ){
                e.stopPropagation();
                e.preventDefault();
                if( $("#selected-categories>li").length === 0 ){
                    $("#available-categories>li").each(function( i, obj ){
                        $(this).appendTo("#selected-categories");
                    });
                }
                $("#selected-categories>li").tsort( {order:'rand'} );
            });

            //Bind clicking to the li elements and send them to the right list
            $( "li" ).click(function( e ){
                e.stopPropagation();
                var currentHome = $(this).parent().attr("id");
                switch( currentHome ){
                    case "available-categories":
                        $(this).appendTo("#selected-categories");
                        var cats = jQuery.map( $("#selected-categories>li"), function( obj, i ){
                            return obj.id;
                        });
                        var comps = jQuery.map( $("#selected-components>li"), function( obj, i ){
                            return obj.id;
                        });
                        if( cats.length >= 2 &&  jQuery.inArray('matching', comps) === -1 ){
                            $("#matching").click();
                        }
                        break;
                    case "available-components":
                        if( this.id === "survey" ){
                            $("#survey-upload").toggle();
                        }
                        $(this).appendTo("#selected-components");
                        $("#selected-components>li").tsort( {data:"order"} );                  
                        break;
                    case "selected-categories":
                        $(this).appendTo("#available-categories");
                        var cats = jQuery.map( $("#selected-categories>li"), function( obj, i ){
                            return obj.id;
                        });
                        var comps = jQuery.map( $("#selected-components>li"), function( obj, i ){
                            return obj.id;
                        });
                        if( cats.length < 2 &&  jQuery.inArray('matching', comps) > -1 ){
                            $("#matching").click();
                        }                  
                        break;
                    case "selected-components":
                        if( this.id === "matching" && $("#selected-categories>li").length >=2 ){
                            if( ! confirm("You have at least 2 categories selected. Are you sure you want to remove the \"Matching\" component?") ){
                                return;
                            }
                        }else if( this.id === "survey" ){
                            $("#survey-upload").toggle();
                        }                        
                        $(this).appendTo("#available-components");
                        $("#available-components>li").tsort( {data:"order"} );
                        break;
                    default:
                        break;
                }
            });

            //Remove error from Survey div
            $("#survey-upload").click(function( e ){
                $(this).removeClass("alert-error");
            });
            $("#id-div").click(function( e ){
                $(this).removeClass("alert-error");
            });

            //Control click event of "Submit" button
            $("#submit").click(function( e ){
                e.stopPropagation();
                e.preventDefault();

                //Create and fill own FormData object to pass to the server because we aren't using a form
                var data = new FormData();                

                //Get Categories
                var cats = jQuery.map( $("#selected-categories>li"), function( obj, i ){
                    return obj.id;
                });

                //Get Components
                var comps = jQuery.map( $("#selected-components>li"), function( obj, i ){
                    return obj.id;
                });

                //Get Theme
                var theme = $("input[name='theme']:checked").attr("value");

                //Get Max Per Category
                var max = $("#maxFriendsPerCategory").val();

                //Get Survey and make a weak check to make sure they uploaded a JSON file if any
                //Server will do a better job...
                if( jQuery.inArray("survey", comps) !== -1 ){
                    var inp = $("input[name='survey-file']")[0];
                    var filename = inp.files ? inp.files.length === 0 ? false : inp.files[0].name.split(".") : false;
                    if( ! filename ){
                        vex.dialog.alert('Please upload a .JSON file for your survey or remove the "Survey" component from your lists');
                        return;
                    }else if ( filename[ filename.length-1 ] !== "json" ) {
                        vex.dialog.alert("It seems you did not upload a .JSON file");
                        $("#survey-upload").addClass("alert-error");
                        return;
                    }else{
                        var file = $("input[name='survey-file']").prop("files")[0];
                        data.append("file", file);
                    }
                }

                //Get appID
                var appID = $("#appID").val();

                //Get description
                var description = $("#description").val();

                data.append("categories", cats);
                data.append("components", comps);
                data.append("theme", theme);
                data.append("max", max);
                data.append("appID", appID);
                data.append("description", description);

                //Check for appID in db
                $.ajax({
                    url: "validate",
                    type: "POST",
                    data: {"appID": appID},
                    success: function( resp ){
                        //Send config to server
                        $.ajax({
                            url: "configure",
                            type: "POST",
                            data: data,
                            processData: false,
                            contentType: false,
                            success: function( resp ){
                                $("body").html(resp);
                            },
                            error: function( resp ){
                                vex.dialog.alert(resp.responseText);
                            }
                        });

                    },
                    error: function( resp ){
                        vex.dialog.alert("That appID already exists.");
                        $("#id-div").addClass("alert-error");
                    }

                });
            });

        </script>
        </body>
    </html>