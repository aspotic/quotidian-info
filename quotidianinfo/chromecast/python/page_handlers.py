import os
import webapp2

from google.appengine.api import memcache
from google.appengine.ext.webapp import template

MEMCACHE_APP_NAME_KEY = 'chromecast_app_name'
default_app_name = 'webViewer'
#default_app_name = 'helloChromecast'
#default_app_name = 'statview'


class SenderPageHandler(webapp2.RequestHandler):
    """
    Handles requests for the statview chromecast sender page
    """
    
    def get(self):
        """Handles the GET requests for the statview chromecast pages"""
        app_name = self.request.get('appName') or default_app_name

        # Save the app name to memcache so it can be used by the receiver handlers
        memcache.set(key=MEMCACHE_APP_NAME_KEY, value=app_name)

        # Set up the path to the template
        path = os.path.join(os.path.dirname(__file__), '../templates', 'sender/{0}.html'.format(app_name))

        # Show the configured template to the user
        self.response.out.write(template.render(path, {}))


class TestPageHandler(webapp2.RequestHandler):
    """
    Handles requests for the statview chromecast pages
    """

    def get(self):
        """Handles the GET requests for the statview chromecast pages"""
        app_name = memcache.get(MEMCACHE_APP_NAME_KEY) or default_app_name

        # Set up the path to the template
        path = os.path.join(os.path.dirname(__file__), '../templates', 'receiver/test/{0}.html'.format(app_name))

        # Show the configured template to the user
        self.response.out.write(template.render(path, {}))


class ProdPageHandler(webapp2.RequestHandler):
    """
    Handles requests for the statview chromecast pages
    """

    def get(self):
        """Handles the GET requests for the statview chromecast pages"""
        app_name = memcache.get(MEMCACHE_APP_NAME_KEY) or default_app_name

        # Set up the path to the template
        path = os.path.join(os.path.dirname(__file__), '../templates', 'receiver/prod/{0}.html'.format(app_name))

        # Show the configured template to the user
        self.response.out.write(template.render(path, {}))