from google.appengine.ext import blobstore
from google.appengine.ext.webapp import blobstore_handlers


class DownloadHandler(blobstore_handlers.BlobstoreDownloadHandler):
    """
    Handles requests to download files from the blobstore by making
    sure they exist, and giving the user access if possible
    """
    
    def get(self, file_key):
        """
        Handles the GET requests to the blobStore DownloaderHandler class
        """
        # If the file exists in the blobstore, let the user save the data to their computer
        if blobstore.get(file_key):
            self.send_blob(blobstore.BlobInfo.get(file_key), save_as=True)
        # If the file doesn't exist in the blobstore, then 404 the user
        else:
            self.error(404)


def deleteBlobs(keyList):
    """
    Def: Deletes all the blobs associated with the keys in the given list
    In: keyList - A list of all the blob keys to the blobs that need to be removed
    """
    for key in keyList:
        blobstore.BlobInfo.delete(key)