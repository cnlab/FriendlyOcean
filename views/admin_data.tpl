            <div class="span4 offset" id="apps">
            %for app in data:
                <div class="span4 app-block">
                    <h3><a data-toggle="collapse" data-target="#{{app['appID']}}-data" class="toggles">{{ app['appID'] }}</a> ({{ len(app['files']) }})</h3>
                    <ul class="app-meta">
                            <li><strong>Owner: </strong>{{ app['owner'] }}</li>
                            <li>|</li>
                            <li><strong>Created: </strong>{{ app['created'] }}</li>
                    </ul>
                    <ul class="data-table collapse" id="{{app['appID']}}-data">
                    %if len(app['files']) > 0:
                        <li><a class="dl-all" href="download-data?type=all&file={{app['appID']}}">download all for {{app['appID']}}</a></li>
                    %for file in app['files']:
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