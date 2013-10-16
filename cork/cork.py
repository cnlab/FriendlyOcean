#!/usr/bin/env python
#
# Cork - Authentication module for tyyhe Bottle web framework
# Copyright (C) 2013 Federico Ceratto and others, see AUTHORS file.
#
# This package is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 3 of the License, or (at your option) any later version.
#
# This package is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

from base64 import b64encode, b64decode
from beaker import crypto
from datetime import datetime, timedelta
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from logging import getLogger
from smtplib import SMTP, SMTP_SSL
from threading import Thread
from time import time
import bottle
import os
import re
import uuid

try:
    import scrypt
    scrypt_available = True
except ImportError:  # pragma: no cover
    scrypt_available = False

from backends import JsonBackend

log = getLogger(__name__)


class AAAException(Exception):
    """Generic Authentication/Authorization Exception"""
    pass

class AuthException(AAAException):
    """Authentication Exception: incorrect username/password pair"""
    pass


class Cork(object):

    def __init__(self, directory=None, backend=None,
        initialize=False, session_domain=None):
        """Auth/Authorization/Accounting class

        :param directory: configuration directory
        :type directory: str.
        :param users_fname: users filename (without .json), defaults to 'users'
        :type users_fname: str.
        :param roles_fname: roles filename (without .json), defaults to 'roles'
        :type roles_fname: str.
        :param apps_fname: apps filename (without .json), defaults to 'apps'
        :type apps_fname: str.        
        """
        self.password_reset_timeout = 3600 * 24
        self.session_domain = session_domain
        self.preferred_hashing_algorithm = 'PBKDF2'

        # Setup JsonBackend by default for backward compatibility.
        if backend is None:
            self._store = JsonBackend(directory, users_fname='users',
                roles_fname='roles', apps_fname='apps',
                initialize=initialize)

        else:
            self._store = backend

    def delete_app(self, appID):
        """
        Delete app from user and database
        """
        user = self.current_user
        try:
            user.update(delApp=appID)
        except:
            raise AAAException("Unable to delete %s" % appID)
        
        try:
            self._store.apps.pop(appID)
            self._store.save_apps()
        except:
            raise AAAException("Unable to delete %s" % appID)



    def save_app(self, app):
        """
        Save app dict to mongo database
        """
        apps = self._store.apps
        apps[app['appID']] = app

        user = self.current_user
        if user is None:
            raise AAAException("Nonexistent user.")

        try:
            user.update(addApp=app['appID'])
            self._store.save_apps()
        except:
            raise AAAException("Unable to save app")

    def load_app(self, appID):
        """
        Load app dict from mongodb
        """
        if appID not in self._store.apps:
            raise AAAException("Unable to load config for %s" % appID)
        
        app = self._store.apps[appID]
        
        return app

    def check_apps_for(self, appID):
        """
        Check appID against database
        """
        if appID in self._store.apps:
            return False
        return True

    def list_apps(self, user=None):
        apps = []
        if user is not None:
            if user.apps:
                for appID in user.apps.split(","):
                    if appID in self._store.apps:
                        apps.append(self._store.apps[appID])
        else:
            for app in self._store.apps:
                apps.append(self._store.apps[app])

        return apps

    def list_data(self):
        logs = os.listdir("logs")
        data = {}
        app_list = self.list_apps()

        for app in app_list:
            appID = app['appID']
            data[appID] = []
            for log in logs:
                if log.startswith(appID) and log.endswith(".json"):
                    data[appID].append(log)
        
        return data

    def login(self, username, password, success_redirect=None,
        fail_redirect=None):
        """Check login credentials for an existing user.
        Optionally redirect the user to another page (tipically /login)

        :param username: username
        :type username: str.
        :param password: cleartext password
        :type password: str.
        :param success_redirect: redirect authorized users (optional)
        :type success_redirect: str.
        :param fail_redirect: redirect unauthorized users (optional)
        :type fail_redirect: str.
        :returns: True for successful logins, else False
        """
        assert isinstance(username, str), "the username must be a string"
        assert isinstance(password, str), "the password must be a string"

        if username in self._store.users:
            if self._verify_password(username, password,
                    self._store.users[username]['hash']):
                # Setup session data
                self._setup_cookie(username)
                if success_redirect:
                    bottle.redirect(success_redirect)
                return True

        if fail_redirect:
            session = self._beaker_session
            session['redir_msg'] = "Invalid username or password!"
            bottle.redirect(fail_redirect)

        return False

    def logout(self, success_redirect=None, fail_redirect=None):
        """Log the user out, remove cookie

        :param success_redirect: redirect the user after logging out
        :type success_redirect: str.
        :param fail_redirect: redirect the user if it is not logged in
        :type fail_redirect: str.
        """
        try:
            session = self._beaker_session
            session.delete()
        except Exception, e:
            log.debug("Exception %s while logging out." % repr(e))
            bottle.redirect(fail_redirect)

        bottle.redirect(success_redirect)

    def require(self, username=None, role=None, fixed_role=False,
        fail_redirect=None):
        """Ensure the user is logged in has the required role (or higher).
        Optionally redirect the user to another page (tipically /login)
        If both `username` and `role` are specified, both conditions need to be
        satisfied.
        If none is specified, any authenticated user will be authorized.
        By default, any role with higher level than `role` will be authorized;
        set fixed_role=True to prevent this.

        :param username: username (optional)
        :type username: str.
        :param role: role
        :type role: str.
        :param fixed_role: require user role to match `role` strictly
        :type fixed_role: bool.
        :param redirect: redirect unauthorized users (optional)
        :type redirect: str.
        """
        # Parameter validation
        if username is not None:
            if username not in self._store.users:
                raise AAAException("Nonexistent user")

        if fixed_role and role is None:
            raise AAAException(
                """A role must be specified if fixed_role has been set""")

        if role is not None and role not in self._store.roles:
            raise AAAException("Role not found")

        # Authentication
        try:
            cu = self.current_user
        except AAAException:
            if fail_redirect is None:
                raise AuthException("Unauthenticated user")
            else:
                bottle.redirect(fail_redirect)

        if cu.role not in self._store.roles:
            raise AAAException("Role not found for the current user")

        if username is not None:
            if username != self.current_user.username:
                if fail_redirect is None:
                    raise AuthException("Unauthorized access: incorrect"
                        " username")
                else:
                    bottle.redirect(fail_redirect)

        if fixed_role:
            if role == self.current_user.role:
                return

            if fail_redirect is None:
                raise AuthException("Unauthorized access: incorrect role")
            else:
                bottle.redirect(fail_redirect)

        else:
            if role is not None:
                # Any role with higher level is allowed
                current_lvl = self._store.roles[self.current_user.role]
                threshold_lvl = self._store.roles[role]
                if current_lvl >= threshold_lvl:
                    return

                if fail_redirect is None:
                    raise AuthException("Unauthorized access: ")
                else:

                    bottle.redirect(fail_redirect)

        return

    def create_role(self, role, level):
        """Create a new role.

        :param role: role name
        :type role: str.
        :param level: role level (0=lowest, 100=admin)
        :type level: int.
        :raises: AuthException on errors
        """
        if self.current_user.level < 100:
            raise AuthException("The current user is not authorized to ")
        if role in self._store.roles:
            raise AAAException("The role is already existing")
        try:
            int(level)
        except ValueError:
            raise AAAException("The level must be numeric.")
        self._store.roles[role] = level
        self._store.save_roles()

    def delete_role(self, role):
        """Deleta a role.

        :param role: role name
        :type role: str.
        :raises: AuthException on errors
        """
        if self.current_user.level < 100:
            raise AuthException("The current user is not authorized to ")
        if role not in self._store.roles:
            raise AAAException("Nonexistent role.")
        self._store.roles.pop(role)
        self._store.save_roles()

    def list_roles(self):
        """List roles.

        :returns: (role, role_level) generator (sorted by role)
        """
        for role in sorted(self._store.roles):
            yield (role, self._store.roles[role])

    def create_user(self, username, first_name, last_name, role, password, email_addr=None,
        organization='', apps=[]):
        """Create a new user account.
        This method is available to users with level>=100

        :param username: username
        :type username: str.
        :param role: role
        :type role: str.
        :param password: cleartext password
        :type password: str.
        :param email_addr: email address (optional)
        :type email_addr: str.
        :param description: description (free form)
        :type description: str.
        :raises: AuthException on errors
        """
        assert username, "Username must be provided."
        if self.current_user.level < 100:
            raise AuthException("The current user is not authorized" \
                " to create users.")

        if username in self._store.users:
            raise AAAException("User already exists.")
        if role not in self._store.roles:
            raise AAAException("Nonexistent user role.")
        creation_date = str(datetime.utcnow())

        self._store.users[username] = {
            'username': username,
            'first_name': first_name,
            'last_name': last_name,
            'organization': organization,
            'role': role,
            'hash': self._hash(username, password),
            'email_addr': email_addr,
            'creation_date': creation_date,
            'apps': apps
        }
        self._store.save_users()

    def delete_user(self, username):
        """Delete a user account.
        This method is available to users with level>=100

        :param username: username
        :type username: str.
        :raises: Exceptions on errors
        """
        if self.current_user.level < 100:
            raise AuthException("The current user is not authorized to ")
        if username not in self._store.users:
            raise AAAException("Nonexistent user.")
        self.user(username).delete()

    def list_users(self):
        """List users.

        :return: (username, role, email_addr) generator (sorted by
        username)
        """
        users = {}
        for un in sorted(self._store.users):
            d = self._store.users[un]
            users[un] = d
        return users

    @property
    def current_user(self):
        """Current autenticated user

        :returns: User() instance, if authenticated
        :raises: AuthException otherwise
        """
        session = self._beaker_session
        username = session.get('username', None)
        if username is None:
            raise AuthException("Unauthenticated user")
        if username is not None and username in self._store.users:
            return User(username, self, session=session)
        raise AuthException("Unknown user: %s" % username)

    @property
    def user_is_anonymous(self):
        """Check if the current user is anonymous.

        :returns: True if the user is anonymous, False otherwise
        :raises: AuthException if the session username is unknown
        """
        try:
            username = self._beaker_session['username']
        except KeyError:
            return True

        if username not in self._store.users:
            raise AuthException("Unknown user: %s" % username)

        return False

    def user(self, username):
        """Existing user

        :returns: User() instance if the user exist, None otherwise
        """
        if username is not None and username in self._store.users:
            return User(username, self)
        return None

    def register(self, username, first_name, last_name, password, email_addr, organization, role='user',
        max_level=50):
        """Register a new user account. An email with a registration validation
        is sent to the user.

        :param username: username
        :type username: str.
        :param first_name: first_name
        :type first_name: str.
        :param last_name: last_name
        :type last_name: str.
        :param password: cleartext password
        :type password: str.
        :param role: role (optional), defaults to 'user'
        :type role: str.
        :param max_level: maximum role level (optional), defaults to 50
        :type max_level: int.
        :param email_addr: email address
        :type email_addr: str.
        :raises: AssertError or AAAException on errors
        """
        assert username, "Username must be provided."
        assert password, "A password must be provided."
        assert email_addr, "An email address must be provided."
        if username in self._store.users:
            raise AAAException("User is already existing.")
        if role not in self._store.roles:
            raise AAAException("Nonexistent role")
        if self._store.roles[role] > max_level:
            raise AAAException("Unauthorized role")

        creation_date = str(datetime.utcnow())

        # store pending registration
        self._store.users[username] = {
            'username': username,
            'first_name': first_name,
            'last_name': last_name,
            'organization': organization,
            'role': role,
            'hash': self._hash(username, password),
            'email_addr': email_addr,
            'creation_date': creation_date,
        }
        self._store.save_users()

    def reset_password(self, username, password):
        """Validate reset_code and update the account password
        The username is extracted from the reset_code token

        :param reset_code: reset token
        :type reset_code: str.
        :param password: new password
        :type password: str.
        :raises: AuthException for invalid reset tokens, AAAException
        """
        user = self.user(username)
        if user is None:
            raise AAAException("Nonexistent user.")
        user.update(pwd=password)

    ## Private methods

    @property
    def _beaker_session(self):
        """Get Beaker session"""
        return bottle.request.environ.get('beaker.session')

    def _setup_cookie(self, username):
        """Setup cookie for a user that just logged in"""
        session = self._beaker_session
        session['username'] = username
        if self.session_domain is not None:
            session.domain = self.session_domain
        session.save()

    def _hash(self, username, pwd, salt=None, algo=None):
        """Hash username and password, generating salt value if required
        """
        if algo is None:
            algo = self.preferred_hashing_algorithm

        if algo == 'PBKDF2':
            return self._hash_pbkdf2(username, pwd, salt=salt)

        if algo == 'scrypt':
            return self._hash_scrypt(username, pwd, salt=salt)

        raise RuntimeError("Unknown hashing algorithm requested: %s" % algo)

    @staticmethod
    def _hash_scrypt(username, pwd, salt=None):
        """Hash username and password, generating salt value if required
        Use scrypt.

        :returns: base-64 encoded str.
        """
        if not scrypt_available:
            raise Exception("scrypt.hash required."
                " Please install the scrypt library.")

        if salt is None:
            salt = os.urandom(32)

        assert len(salt) == 32, "Incorrect salt length"

        cleartext = "%s\0%s" % (username, pwd)
        h = scrypt.hash(cleartext, salt)

        # 's' for scrypt
        return b64encode('s' + salt + h)

    @staticmethod
    def _hash_pbkdf2(username, pwd, salt=None):
        """Hash username and password, generating salt value if required
        Use PBKDF2 from Beaker

        :returns: base-64 encoded str.
        """
        if salt is None:
            salt = os.urandom(32)
        assert len(salt) == 32, "Incorrect salt length"

        cleartext = "%s\0%s" % (username, pwd)
        h = crypto.generateCryptoKeys(cleartext, salt, 10)
        if len(h) != 32:
            raise RuntimeError("The PBKDF2 hash is %d bytes long instead"
                "of 32. The pycrypto library might be missing." % len(h))

        # 'p' for PBKDF2
        return b64encode('p' + salt + h)

    def _verify_password(self, username, pwd, salted_hash):
        """Verity username/password pair against a salted hash

        :returns: bool
        """
        decoded = b64decode(salted_hash)
        hash_type = decoded[0]
        salt = decoded[1:33]

        if hash_type == 'p':  # PBKDF2
            h = self._hash_pbkdf2(username, pwd, salt)
            return salted_hash == h

        if hash_type == 's':  # scrypt
            h = self._hash_scrypt(username, pwd, salt)
            return salted_hash == h

        raise RuntimeError("Unknown hashing algorithm: %s" % hash_type)


class User(object):

    def __init__(self, username, cork_obj, session=None):
        """Represent an authenticated user, exposing useful attributes:
        username, role, level, description, email_addr, session_creation_time,
        session_accessed_time, session_id. The session-related attributes are
        available for the current user only.

        :param username: username
        :type username: str.
        :param cork_obj: instance of :class:`Cork`
        """
        self._cork = cork_obj
        assert username in self._cork._store.users, "Unknown user"
        self.username = username
        user_data = self._cork._store.users[username]
        self.role = user_data['role']
        self.email_addr = user_data['email_addr']
        self.level = self._cork._store.roles[self.role]
        apps = user_data.get('apps', None)
        self.apps = apps
        self.first_name = user_data['first_name']


        if session is not None:
            try:
                self.session_creation_time = session['_creation_time']
                self.session_accessed_time = session['_accessed_time']
                self.session_id = session['_id']
            except:
                pass

    def update(self, role=None, pwd=None, email_addr=None, addApp=None, delApp=None):
        """Update an user account data

        :param role: change user role, if specified
        :type role: str.
        :param pwd: change user password, if specified
        :type pwd: str.
        :param email_addr: change user email address, if specified
        :type email_addr: str.
        :param appID: add/remove app to user's list
        :type appID: str.
        :raises: AAAException on nonexistent user or role.
        """
        username = self.username
        if username not in self._cork._store.users:
            raise AAAException("User does not exist.")

        if role is not None:
            if role not in self._cork._store.roles:
                raise AAAException("Nonexistent role.")

            self._cork._store.users[username]['role'] = role

        if pwd is not None:
            self._cork._store.users[username]['hash'] = self._cork._hash(
                username, pwd)

        if email_addr is not None:
            self._cork._store.users[username]['email_addr'] = email_addr

        if addApp is not None:
            apps = self._cork._store.users[username].get("apps", "")
            if apps is not "":
                apps = apps.split(",")
                apps.append(addApp)
                for app in apps:
                    if app == "":
                        apps.remove(app)
                apps = ",".join(apps)
            else:
                apps += addApp
            self._cork._store.users[username]['apps'] = apps

        if delApp is not None:
            apps = self._cork._store.users[username].get("apps", "")
            if apps is not "":
                apps = apps.split(",")
                apps.remove(delApp)
                if len(apps) < 1:
                    apps = ""
                else:
                    apps = ",".join(apps)

                self._cork._store.users[username]['apps'] = apps

        self._cork._store.save_users()

    def delete(self):
        """Delete user account

        :raises: AAAException on nonexistent user.
        """
        try:
            self._cork._store.users.pop(self.username)
        except KeyError:
            raise AAAException("Nonexistent user.")
        self._cork._store.save_users()

