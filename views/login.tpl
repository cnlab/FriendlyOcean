<!DOCTYPE html>
<html lang="en">
    <head>
    <title>Login | Friendly Island</title>
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    </head>
    <body>
        <div clss="container">
            <div class="row">
                <div class="span4 offset4">
                  <div class="well">
                    <legend>Sign in to Friendly Island</legend>
                    %if defined('error'):
                    <div class="alert alert-error">
                        <a class="close" data-dismiss="alert" href="#">x</a>{{ error }}
                    </div>
                    %end
                    <form method="POST" accept-charset="UTF-8">
                        <input class="span3" placeholder="Username" type="text" name="username">
                        <input class="span3" placeholder="Password" type="password" name="password"> 
                        <button class="btn-info btn" type="submit">Login</button>      
                    </form>    
                  </div>
                </div>
            </div>
        </div>

        <!--Javascripts-->
        <script type="text/javascript" src="assets/js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="assets/js/bootstrap.min.js"></script>
    </body>
</html>