<!DOCTYPE html>
<html lang="en">
    <head>
    <title>Login | Friendly Island</title>
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <style>
        body{
            background: #f1f1f1;
        }
        .center{
            width: 29%;
            height: 50%;
            overflow: auto;
            margin: auto;
            position: absolute;
            top: 0; left: 0; bottom: 0; right: 0;
        }
        #login-div{
            -webkit-border-radius: 20px;
            -moz-border-radius: 20px;
            border-radius: 20px;
            background: #6e90ac;
            padding: 15px 50px;
        }
        .alert{
            position: relative;
            top: 70%;            
        }
        .close{
            z-index: 100;
        }
    </style>
    </head>
    <body>
        %if defined('error'):
        <div class="center">
            <div class="alert alert-error">
                <a class="close" data-dismiss="alert" href="#">x</a>
                {{ error }}
            </div>
        </div>
        %end
        <div class="center">
            <div id="login-div">
            <legend>Sign in to Friendly Island</legend>
            <form method="POST" accept-charset="UTF-8">
                <input class="span3" placeholder="Username" type="text" name="username">
                <input class="span3" placeholder="Password" type="password" name="password"> 
                <button class="btn-info btn" type="submit">Login</button>      
            </form>  
            </div>  
        </div>
        <!--Javascripts-->
        <script type="text/javascript" src="assets/js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="assets/js/bootstrap.min.js"></script>
    </body>
</html>