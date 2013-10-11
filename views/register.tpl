<!DOCTYPE html>
<html lang="en">
    <head>
    
    <title>Register | Friendly Island</title>
    
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent" />
    
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">

    </head>
    
    <body>
        
        <div class="container">
            <div class="page-header">
                <h1>Regsiter with Friendly Island</h1>
            </div>

            <div class="row">
                <div class="span5 offset1">
                    <form class="form-horizontal" id="register" method="POST"`>
                        <fieldset>

                        <!-- Text input-->
                        <div class="control-group">
                          <label class="control-label" for="first_name">First Name</label>
                          <div class="controls">
                            <input id="first_name" name="first_name" type="text" placeholder="" class="input-xlarge">
                            
                          </div>
                        </div>

                        <!-- Text input-->
                        <div class="control-group">
                          <label class="control-label" for="last_name">Last Name</label>
                          <div class="controls">
                            <input id="last_name" name="last_name" type="text" placeholder="" class="input-xlarge">
                            
                          </div>
                        </div>

                        <!-- Text input-->
                        <div class="control-group">
                          <label class="control-label" for="email_addr">Email</label>
                          <div class="controls">
                            <input id="email_addr" name="email_addr" type="text" placeholder="" class="input-xlarge">
                            
                          </div>
                        </div>

                        <!-- Text input-->
                        <div class="control-group">
                          <label class="control-label" for="organization">Organization</label>
                          <div class="controls">
                            <input id="organization" name="organization" type="text" placeholder="" class="input-xlarge">
                            
                          </div>
                        </div>

                        <!-- Text input-->
                        <div class="control-group">
                          <label class="control-label" for="username">Username</label>
                          <div class="controls">
                            <input id="username" name="username" type="text" placeholder="" class="input-xlarge">
                            
                          </div>
                        </div>

                        <!-- Password input-->
                        <div class="control-group">
                          <label class="control-label" for="password">Password</label>
                          <div class="controls">
                            <input id="password" name="password" type="password" placeholder="" class="input-xlarge">
                            
                          </div>
                        </div>

                        <!-- Password confirm input-->
                        <div class="control-group">
                          <label class="control-label" for="password_confirm">Confirm Password</label>
                          <div class="controls">
                            <input id="password_confirm" name="password_confirm" type="password" placeholder="" class="input-xlarge">
                            
                          </div>
                        </div>

                        <!-- Buttons -->
                        <div class="control-group">
                          <label class="control-label" for="submit"></label>
                          <div class="controls">
                            <button id="submit" name="submit" class="btn btn-primary">Submit</button>
                          </div>
                        </div>

                        </fieldset>
                    </form>

                </div>
            </div>


        </div>



    <!--Other people's Javascripts-->
    <script type="text/javascript" src="assets/js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="assets/js/jquery.validate.min.js"></script>
    <script type="text/javascript">
        $("#register").validate({
              onfocuseout: true,
              onkeyup: false,
              rules: {
                 username: {
                     required: true,
                     remote: {
                         url: "validate",
                         type: "post"
                     }
                 },
                 first_name: {
                     required: true
                 },
                 last_name: {
                     required: true
                 },
                 password: {
                     required: true,
                     rangelength:[8,20]
                 },
                 password_confirm: {
                     required: true,
                     equalTo: '#password'
                 },
                 email_addr: {
                     required: true,
                     email: true
                 }
              },
              messages: {
                 first_name: "Please enter your first name.",
                 last_name: "Please enter your last name.",
                 username: {
                     required: "Please enter a username.",
                     remote: "This username already exists."
                 },
                 password: {
                     required: "Please enter a password.",
                     rangelength: "Please enter between 8 and 20 characters.",
                     min: "Please enter between 8 and 20 characters.",
                 },
                 password_confirm: {
                     required: "Please re-enter your password.",
                     equalTo: "Please confirm your password."
                 },
                 email_addr: {
                     required: "Please enter an email address.",
                     email: "Please enter a valid email address."
                 }
              }
         });
    </script> 
    </body>
</html>