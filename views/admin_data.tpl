            <div class="span4 offset1" id="apps">
            %for app in data:
                <div class="span4 app-block">
                    <h3><a data-toggle="collapse" data-target="#{{app}}-data" class="toggles">{{ app }}</a> ({{ len(data[app]) }})</h3>
                    <ul class="app-meta">
                        <li><strong>Owner:</strong> {{ apps[app]['owner'] }}</li>
                        <li><strong>Created:</strong> {{ apps[app]['created'] }}</li>
                    </ul>
                    <ul class="data-table collapse" id="{{app}}-data">
                    %if len(data[app]) > 0:
                        <li><a class="dl-all" href="download-data?type=all&file={{app}}">download all for {{app}}</a></li>
                    %for file in data[app]:
                        <li>{{ file }} <small><a class="view" href="" data-file="{{file}}">view</a>  |  <a class="dl-one" href="download-data?type=one&file={{file}}">download</a></small></li>
                    %end
                    %else:
                        <li><p class="lead">No data yet!</p></li>
                    %end 
                    </ul>
                </div>
            %end
            </div>