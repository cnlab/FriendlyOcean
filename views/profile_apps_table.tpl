                    %if defined('msg'):
                    <div class="alert alert-{{ msg['type'] }}">
                      <button type="button" class="close" data-dismiss="alert">&times;</button>
                      <strong>{{ msg['text'] }}</strong>
                    </div>                            
                    %end
                    %if defined('apps'):
                    %if len(apps) < 1:
                    <h3>You have no apps!</h3>
                    <p class="lead"><a href="configure">Make one!</a></p>
                    %else:
                    <h3>Here are your apps <small>(<a href="configure">Configure Another App</a>)</small></h3>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Created</th>
                                    <th>App ID</th>
                                    <th>Link</th>
                                    <th>Description</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                %for app in apps:
                                <tr>
                                    <td>{{ app['created'] }}</td>
                                    <td>{{ app['appID'] }}</td>
                                    <td><a href="?appID={{ app['appID'] }}">http://cnlab.info/fidev/?appID={{ app['appID'] }}</a></td>
                                    <td>{{ app['description'] }}</td>
                                    <td><a href="my-data?filter={{app['appID']}}">See data</a></td>
                                </tr>
                                %end
                            </tbody>
                        </table>
                    %end
                    %else:
                    <h3>You have no apps!</h3>
                    <p class="lead"><a href="configure">Make one!</a></p>
                    %end