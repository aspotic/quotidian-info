import webapp2
from common import vars, func


class PageHandler(webapp2.RequestHandler):
    """
    Handles requests for the bio page by putting together the proper variables and returning the html template that uses them
    """
    
    def get(self):
        """Handles the GET requests to the bio PageHandler class"""
        # Displays the bio template with the bio page's metadata
        func.showTemplate(self, 'home.html', {"metaData" : vars.metaData_Bio})
