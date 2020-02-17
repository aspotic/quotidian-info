import webapp2
from collections import namedtuple
from datetime import datetime
from google.appengine.api import images
from google.appengine.ext.webapp import blobstore_handlers

from common import vars, func
from controllers.blobStore import deleteBlobs
from models import models


class UploadHandler(blobstore_handlers.BlobstoreUploadHandler):
    """
    Handles uploading the actual graphic art image to the blobstore, its metadata to the datastore, and an RSS feed entry for it
    """
    
    def post(self):
        """
        Handle POST requests to graphicArt UploadHandler class
        """
        
        # Get GET variables
        title = self.request.get('title')
        imageType = self.request.get('type')
        
        # Build the RSS feed item entry
        rssObj = models.RSSEntry(
            title=title,
            description='Category: Graphic Art<br /><br />New image uploaded to ' + imageType,
            link='http://quotidian.info/graphicArt/entry/' + title.replace(' ', '_')
        )

        # If Putting the art object in the RSS feed worked, then save the data for it too
        if rssObj.put():
            # Get formerly uploaded blob object's key for data store reference to blob store value
            upload_files = self.get_uploads('image')
            blob_info = upload_files[0]
            
            # Build the art object with proper form data
            graphicArtObj = models.GraphicArt(
                date=datetime.now(),
                title=title.replace(' ', '_'),      # Strip spaces in title and use underscore instead
                type=imageType,
                image=blob_info.key()
            )
            
            # Put the art object in the data store
            if graphicArtObj.put():
                self.redirect('/admin')
                return
            else:
                self.response.out.write("Error Uploading Graphic Art, RSS feed item upload was successful")
        else:
            self.response.out.write(
                "Error Uploading Graphic Art RSS Feed. Name probably exists already, but that may not be the problem."
            )

        # Failed to complete an operation because the function hasn't already returned
        # so remove the blob data created during this operation
        deleteBlobs([blob_info.key()])


class PageHandler(webapp2.RequestHandler):
    """
    Handles requests for the public graphic art listing page by putting together the proper variables and returning the html template that uses them
    """
    
    def get(self, variables):
        """
        Handle GET requests to graphicArt PageHandler class
        """
        
        # Split up all the commands and remove any empty commands (//)    
        variables = filter(None, (variables.split('/')))
        
        # Use the default variables if they are not available
        specifier = ''
        if not variables:
            action = 'list'
        elif 1 <= len(variables):
            action = variables[0]
            if 2 <= len(variables):
                specifier = variables[1]
  
        # listing entries for a category
        if 'list' == action:
            # Choose the defoult sub category since none was given
            if '' == specifier:
                specifier = vars.default_graphicArt
        
            # Query datastore for art objects
            query = models.GraphicArt.query().filter(models.GraphicArt.type == specifier)        
            dbObjList = query.fetch(vars.request_size, offset=0)
            
            # Got data from datastore so try to show the template
            if dbObjList:
                
                # Create the objects to send to the template
                Tile = namedtuple('Tile', 'title url key')
                tileData = []

                # Build all named tuples with appropriate data for the template
                for item in dbObjList:
                    
                    # Convert title underscores to spaces for display purposes
                    title = item.title.replace('_', ' ')
                    
                    # Get a URL that will be used to access the image
                    image_url = images.get_serving_url(item.image)
                    
                    # Create the tuple of data and add it to the list to be sent to the template
                    entry = Tile(title, image_url, item.image)
                    tileData.append(entry)
                
                # Display the graphic art template with all customization data
                func.showTemplate(self, 'graphicArt.html', {"tileData": tileData, "metaData": vars.metaData_GraphicArt})
                return
        
        # Displaying a specific item
        elif 'entry' == action and '' != specifier:
            # Query datastore for art object
            query = models.GraphicArt.query(models.GraphicArt.title == specifier)        
            dbObj = query.fetch(1)[0]
            
            # If there is a matching entry, then show it
            if dbObj:
                
                # Set up the data to be sent to the template
                Tile = namedtuple('Tile', 'url title size')
                imageData = Tile(images.get_serving_url(dbObj.image),  dbObj.title.replace('_', ' '), '800')
                
                # Show the customized template
                func.showTemplate(self, 'wrappedImage.html', {"imageData" : imageData})
                return
            
        # Every action failed so show an error
        self.abort(404)