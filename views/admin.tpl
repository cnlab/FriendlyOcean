<!DOCTYPE html>
<html lang="en">
    <head>
    <title>Admin | Friendly Island</title>
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <style>
        ul.data-table,
        ul.app-meta{
            list-style:none;
        }
        ul.app-meta>li{
            display: inline;
        }
        ul.app-meta>li:not(:first-child){
            margin-left: 10px;
        }
        ul.data-table>li{
            margin-bottom: 5px;
        }
        ul.data-table>li:not(:first-child):hover{
            background: #ffffff;
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
        <div class="container">
            <div class="span12 row">
                <h1>Friendly Admin</h1>
                <ul class="nav nav-tabs">
                  <li class="active"><a href="#users" data-toggle="tab">Users</a></li>
                  <li><a href="#apps" data-toggle="tab">Apps</a></li>
                  <li><a href="#data" data-toggle="tab">Data</a></li>
                </ul>
            </div>
            <div class="row">
                <div class="span12">
                    <div id="admin-data" class="tab-content">
                        <div class="tab-pane fade active in" id="users">
                            %include admin_users users=users
                        </div>
                        <div class="tab-pane fade" id="apps">
                            %include admin_apps apps=apps
                        </div>
                        <div class="tab-pane fade" id="data">
                            %include admin_data data=data, apps=apps
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Javascripts-->
        <script type="text/javascript" src="assets/js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="assets/js/bootstrap.min.js"></script>        
    </body>
</html>