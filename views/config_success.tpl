<div class="container">
    <div class="page-header">
        <h1>Success!</h1>
    </div>

<div class="row">
    <div class="span2 well">
        <h4>Your app ID</h4>
        <p style="margin-left:20px;">{{ appID }}</p>
        <h4>Download Link</h4>
        <p style="margin-left:20px;"><a href="assets/apps/{{ appID }}.py">{{ appID }}.py</a></p>
    </div>
    <div class="span8 offset1">
        <h3>Instructions</h3>
            <p>Use the form on the left to customize a version of the Friendly Island app. Check the boxes for each category and component you would like to include.</p>
            <p>When you click the submit button, a zip file containg your <code>config.py</code> file, your appID, and some instructions on accessing your data will be downloaded. Place the <code>config.py</code> file in the root directory of the app (the same folder where you find <code>default_config.py</code>), overwriting any other instance of <code>config.py</code>.</p>
            <p>Do not edit or modify <code>default_config.py</code> because it is the base class that <code>config.py</code> extends. If you want to save the original <code>config.py</code> file that ships with this app, simply rename it to something like <code>orig_config.py</code>.</p>
    </div>
</div>