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
            <p style="margin-left:20px;"><a href="?appID={{ appID }}">http://friendlyisland.info?appID={{ appID }}</a></p>

            <h4>Your profile</h4>
            <p style="margin-left:20px;"><a href="profile">http://friendlyisland.info/profile</a></p>

            <h4>Your log data <small>Nothing there yet...</small></h4>
            <p style="margin-left:20px;"><a href="my-data?filter={{appID}}">http://friendlyisland.info/my-data?filter={{appID}}</a></p>
        </div>
    </div>
</div>