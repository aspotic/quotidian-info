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
    Handles uploading the actual software code to the blobstore and its metadata to the datastore
    """
    
    def post(self):
        """Handle POST requests to software UploadHandler class"""
        
        # Strip spaces in title and use underscores instead
        title = self.request.get('title')
        
        # Build the RSS feed item entry
        rssObj = models.RSSEntry(
            title=title,
            description='Category: Software<br /><br />' + self.request.get('rssSummary'),
            link='http://quotidian.info/software/entry/' + title.replace(' ', '_')
        )
        
        
        # If Putting the software object in the RSS feed worked, then save the data for it too
        if rssObj.put():
            
            # Build the software object with proper form data
            softwareObj = models.Software(
                title=title.replace(' ', '_'),
                date=datetime.now(),
                language=self.request.get('language'),
                description=self.request.get('description'),
                displayPicture=self.get_uploads('displayPicture')[0].key(),
                image1=self.get_uploads('screenImg1')[0].key(),
                image2=self.get_uploads('screenImg2')[0].key(),
                image3=self.get_uploads('screenImg3')[0].key(),
                zipFile=self.get_uploads('softwareFile')[0].key()
            )
            
            # Put the software object in the data store
            if softwareObj.put():
                self.redirect('/admin')
                return
            else:
                self.response.out.write("Error Uploading Software.")
        else:
            self.response.out.write("Error Uploading Software RSS Feed Item")
            
        # Failed to complete an operation because the funcion hasn't already returned
        # so remove the blob data created during this operation
        deleteBlobs([
            self.get_uploads('displayPicture')[0].key(),
            self.get_uploads('screenImg1')[0].key(),
            self.get_uploads('screenImg2')[0].key(),
            self.get_uploads('screenImg3')[0].key(),
            self.get_uploads('softwareFile')[0].key()
        ])


class PageHandler(webapp2.RequestHandler):
    """
    Assembles the software data, then sends it to a template and displays said template
    """
    
    def get(self, variables):
        """
        Handle GET requests to software PageHandler class
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
                
        # Display the software list template if no individual project is given
        if 'list' == action:
            # Choose the defoult sub category since none was given
            if '' == specifier:
                specifier = vars.default_software
                
            # Query the datastore for software objects
            query = models.Software.query().filter(models.Software.language == specifier)        
            dbObjList = query.fetch(vars.request_size, offset=0)
            
            # Got data from datastore so try to show the template
            if dbObjList:
                # Create the objects to send to the template
                tileData = []
                Tile = namedtuple('Tile', 'title language display_url item_url')
                
                # Build all named tuples with appropriate data for the template
                for item in dbObjList:
                    tileData.append(
                        Tile(
                            item.title.replace('_', ' '),
                            item.language,
                            images.get_serving_url(item.displayPicture),
                            "/software/entry/" + item.title
                        )
                    )
                
                # Display the software listing template with all customization data
                func.showTemplate(self, 'software.html', {"tileData" : tileData, "metaData" : vars.metaData_Software})
                return
        
        # Displaying a specific item
        elif 'entry' == action and '' != specifier:
            
            # Query the datastore for software object
            query = models.Software.query().filter(models.Software.title == specifier)        
            dbData = query.fetch(1, offset=0)[0]
            
            # Got the datastore entry so use a template to display its data
            if dbData:
                
                # Build a named tuple to send to the template
                Tile = namedtuple(
                    'Tile',
                    'title description language display_url image1_url image2_url image3_url file_key'
                )

                displayData = Tile(
                    dbData.title.replace('_', ' '),
                    dbData.description,
                    dbData.language,
                    images.get_serving_url(dbData.displayPicture),
                    images.get_serving_url(dbData.image1),
                    images.get_serving_url(dbData.image2),
                    images.get_serving_url(dbData.image3),
                    dbData.zipFile
                )
                
                # Display the software item template with all customization data
                func.showTemplate(self, 'softwareItem.html', {"tile" : displayData})
                return
            
        # Every action failed so show an error
        self.abort(404)