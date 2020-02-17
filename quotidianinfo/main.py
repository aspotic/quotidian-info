import logging
import os
import webapp2
from google.appengine.ext.webapp import template
from google.appengine.ext.webapp.util import run_wsgi_app
from webapp2_extras.routes import RedirectRoute

from chromecast.python import page_handlers
from common import vars
from controllers import blobStore, rss, admin, bio, graphicArt, software
from controllers import giphy


def handle_404(request, response, exception):
    """
    Handles any 404 'page not found' errors by logging the error and showing the user a custom 404 page
    """
    logging.exception(exception)
    path = os.path.join(os.path.dirname(__file__), 'views', '404.html')
    response.write(
        template.render(path,
            {
                "extendFile": vars.base,
                "style": vars.style
            }
        )
    )
    response.set_status(404)


def handle_500(request, response, exception):
    """
    Handles any 500 'internal server' errors by logging the error and showing the user a custom 500 page
    """
    logging.exception(exception)
    path = os.path.join(os.path.dirname(__file__), 'views', '500.html')
    response.write(
        template.render(path, {
            "extendFile": vars.base,
            "style": vars.style
        })
    )
    response.set_status(500)


def main():
    """

    """
    # Create the directories/files that the server needs to respond to, and tell it how to respond to them
    routes = [

        RedirectRoute('/giphy', strict_slash=True, name='giphy', handler=giphy.GiphyHandler),

        # RedirectRoute('/gaUpload', strict_slash=True, name='graphic_art_upload', handler=graphicArt.UploadHandler),
        # RedirectRoute('/softwareUpload', strict_slash=True, name='software_upload', handler=software.UploadHandler),
        # RedirectRoute('/admin', strict_slash=True, name='admin', handler=admin.PageHandler),
        # RedirectRoute('/graphicArt', strict_slash=True, name='graphic_art', redirect_to='/graphicArt/list/' + vars.default_graphicArt),
        # RedirectRoute('/software', strict_slash=True, name='graphic_art', redirect_to='/software/list/' + vars.default_graphicArt),
        # RedirectRoute('/rss.xml', strict_slash=True, name='rss', handler=rss.PageHandler),
        # RedirectRoute('/cc/statview-test.html', strict_slash=True, name='statview_test', handler=page_handlers.TestPageHandler),
        # RedirectRoute('/cc/statview-prod.html', strict_slash=True, name='statview_prod', handler=page_handlers.ProdPageHandler),
        # RedirectRoute('/cc/sender.html', strict_slash=True, name='sender', handler=page_handlers.SenderPageHandler),
        #
        # (r'/graphicArt[/]?(.*)', graphicArt.PageHandler),
        # (r'/software[/]?(.*)', software.PageHandler),
        # (r'/file/([^/]+)?', blobStore.DownloadHandler),
        # RedirectRoute('/', strict_slash=True, name='home', handler=bio.PageHandler),
    ]
    
    app = webapp2.WSGIApplication(routes, debug=False)
    #app.error_handlers[404] = handle_404
    #app.error_handlers[500] = handle_500
    
    run_wsgi_app(app)


if __name__ == "__main__":
    main()

        



