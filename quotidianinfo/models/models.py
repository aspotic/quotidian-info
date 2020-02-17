from google.appengine.ext import ndb


class RSSEntry(ndb.Model):
    title = ndb.StringProperty(required=True)
    description = ndb.StringProperty(required=True)
    pubDate = ndb.DateTimeProperty(auto_now_add=True)
    link = ndb.StringProperty(required=True)


class GraphicArt(ndb.Model):
    title = ndb.StringProperty(required=True)
    date = ndb.DateTimeProperty(auto_now_add=True)
    typ = ndb.StringProperty(required=True)
    image = ndb.BlobKeyProperty(required=True)


class Software(ndb.Model):
    title = ndb.StringProperty(required=True)
    date = ndb.DateTimeProperty(auto_now_add=True)
    language = ndb.StringProperty(required=True)
    description = ndb.TextProperty(required=True)
    displayPicture = ndb.BlobKeyProperty(required=True)
    image1 = ndb.BlobKeyProperty(required=True)
    image2 = ndb.BlobKeyProperty(required=True)
    image3 = ndb.BlobKeyProperty(required=True)
    zipFile = ndb.BlobKeyProperty(required=True)