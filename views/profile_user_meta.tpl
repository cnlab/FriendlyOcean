                <ul class="user-meta">
                    %if user.role == "admin":
                    <li><a href="admin">Admin</a></li>
                    <li>|</li>
                    %end
                    <li><a href="profile">My Profile</a></li>
                    <li>|</li>
                    <li><a href="my-data">My Data</a></li>
                    <li>|</li>
                    <li><a href="logout">Logout</a></li>
                </ul>