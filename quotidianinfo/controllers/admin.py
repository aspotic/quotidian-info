from common import vars

import os
import webapp2

from google.appengine.ext import blobstore
from google.appengine.ext.webapp import template


class PageHandler(webapp2.RequestHandler):
    """
    Handles requests for the administration page by putting together the proper
    variables and returning the html template that uses them
    """
    
    def get(self):
        """
        Handles the GET requests to the admin PageHandler class.
        Takes a parameter 'action' to specify the admin panel to display
        """
        # Get the 'action' variable to choose what to show the administrator
        action = self.request.get('action')
        
        # Shows the home page of the administration module
        if action == '':
            
            # Set up the path to the admin panel template
            path = os.path.join(os.path.dirname(__file__), '../views', 'admin.html')
            
            # Show the configured template to the user
            self.response.out.write(template.render(path, {
                'extendFile' : vars.base,
                'style' : vars.style,
                'gaUpload_url' : blobstore.create_upload_url('/gaUpload'),
                'softwareUpload_url' : blobstore.create_upload_url('/softwareUpload'),
                'metaData' : vars.metaData_Admin
            }))
        
        # Administrator entered an invalid action, so let them know
        else:
            self.response.out.write("Invalid action")