                    %if defined('msg'):
                    <div class="alert alert-{{ msg['type'] }}">
                      <button type="button" class="close" data-dismiss="alert">&times;</button>
                      <strong>{{ msg['text'] }}</strong>
                    </div>                            
                    %end
                    %if defined('apps'):
                    %if len(apps) < 1:
                    <h3>There are no apps!</h3>
                    <p class="lead"><a href="configure">Make one!</a></p>
                    %else:
                    <h3>These are all of the apps in the database</h3>
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Created</th>
                                    <th>Owner</th>
                                    <th>Owner Email</th>
                                    <th>App ID</th>
                                    <th>Description</th>
                                </tr>
                            </thead>
                            <tbody>
                                %for app in apps:
                                <tr>
                                    <td>{{ app['created'] }}</td>
                                    <td>{{ app['owner'] }}</td>
                                    <td>{{ users[app['owner']]['email_addr'] }}</td>
                                    <td>{{ app['appID'] }}</td>
                                    <td>{{ app['description'] }}</td>
                                </tr>
                                %end
                            </tbody>
                        </table>
                    %end
                    %else:
                    <h3>You have no apps!</h3>
                    <p class="lead"><a href="configure">Make one!</a></p>
                    %end