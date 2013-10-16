%if len(users) < 1:
<p class="lead">No users yet!</p>
%else:
<h3>These are all of the users in the database</h3>
<table id="users-table" class="table table-striped table-hover">
    <thead>
        <tr>
            <th>Name</th>
            <th>Username</th>
            <th>Email</th>
            <th>Organization</th>
            <th>Number of apps</th>
            <th></th>
        </tr>
    </thead>
    <tbody>
    %for user in users:
    <tr>
        <td>{{ users[user]['first_name'] }} {{ users[user]['last_name'] }}</td>
        <td>{{ users[user]['username'] }}</td>
        <td>{{ users[user]['email_addr'] }}</td>
        <td>{{ users[user]['organization'] }}</td>
        <td>{{ len(users[user]['apps'].split(",")) }}</td>
        <td><a href="#">Reset Password</a></td>
    </tr>
    %end
    </tbody>
</table>
%end
