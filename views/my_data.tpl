<!DOCTYPE html>
<html lang="en">
    <head>
    <title> My Data | Friendly Island</title>
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <style>
        ul.data-table{
            list-style:none;
        }
        ul.data-table>li{
            margin-bottom: 5px;
        }
        ul.data-table>li:not(:first-child):hover{
            background: #ffffff;
        }
        ul.user-meta{
            list-style:vnone;
            position: absolute;
            top: 0;
            right: 0;
            margin: 15px;
        }
        ul.user-meta>li{
            display: inline;
        }
        ul.user-meta>li:not(:first-child){
            margin-left:8px;
        }
        .toggles,
        .toggles:hover,
        .toggles:active{
            cursor:pointer;
            text-decoration: none;
        }
        div.app-block{
            padding: 5px;
            margin-bottom: 15px;
        }
        div.app-block:hover{
            background-color:#f1f1f1;
        }
        div.app-block:nth-child(even){
            border-left: 4px solid rgb(255,160,48);
        }
        div.app-block:nth-child(odd){
            border-left: 4px solid rgb(180,48,255);
        }
    </style>
    </head>
    <body>

        %include profile_user_meta user=user

        <div class="container">
            <div class="page-header">
                <h1>My Data</h1>
                <p><a href="my-data">Clear filter</a></p>
                <h4>Your apps and data files are listed below on the left. Click an app ID to expand or collapse its list of data files.</h4>
            </div>
            <div class="span3 offset1" id="apps">
            %for app in apps:
                <div class="span3 app-block">
                    <h3><a data-toggle="collapse" data-target="#{{app}}-data" class="toggles">{{ app }}</a> ({{ len(apps[app]) }})</h3>
                    <ul class="data-table collapse" id="{{app}}-data">
                    %if len(apps[app]) > 0:
                        <li><a class="dl-all" href="download-data?type=all&file={{app}}">download all for {{app}}</a></li>
                    %for file in apps[app]:
                        <li>{{ file }} <small><a class="view" href="" data-file="{{file}}">view</a>  |  <a class="dl-one" href="download-data?type=one&file={{file}}">download</a></small></li>
                    %end
                    %else:
                        <li><p class="lead">No data yet!</p></li>
                    %end 
                    </ul>
                </div>
            %end
            </div>
            <div class="span4 offset2">
                <a href="" id="clear-viewer">clear</a>
                <pre id="viewer" class="collapse"></pre>
            </div>
        </div>

        <!--Javascripts-->
        <script type="text/javascript" src="assets/js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="assets/js/bootstrap.min.js"></script> 

        <script type="text/javascript">
            //Set behavior for view link
            $("a.view").click(function( e ){
                e.preventDefault();
                e.stopPropagation();
                $.post("view-file", {"file": this.dataset.file}, function( response ){
                    $("#viewer").html( response ).collapse("show");
                });
            });

            //Clear the view
            $("#clear-viewer").click( function( e ){
                e.preventDefault();
                e.stopPropagation();
                $("#viewer").on("hidden", function( e) {$(this).html("");}).collapse("hide");
            });

        </script>       
    </body>
</html>