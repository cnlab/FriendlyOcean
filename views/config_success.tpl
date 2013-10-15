<div class="container">
    <div class="page-header">
        <h1>Success!</h1>
    </div>

    <div class="row">
        <div class="span12">
            <h2>Now what?</h2>
        </div>
    </div>
    <div class="row">
        <div class="span5 well">

            <h4>Your app's ID</h4>
            <p style="margin-left:20px;">{{ appID }}</p>

            <h4>Your app's link</h4>
            <p style="margin-left:20px;"><a href="?appID={{ appID }}">http://cnlab.info/fidev/?appID={{ appID }}</a></p>

            <h4>Your profile</h4>
            <p style="margin-left:20px;"><a href="profile">http://cnlab.info/fidev/profile</a></p>

            <h4>Your log data <small>Nothing there yet...</small></h4>
            <p style="margin-left:20px;"><a href="{{appID}}/logs">http://cnlab.info/fidev/{{appID}}/logs</a></p>
        </div>
    </div>
</div>