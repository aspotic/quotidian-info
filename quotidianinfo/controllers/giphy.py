import json
import webapp2
import urllib
from urllib2 import urlopen


class GiphyHandler(webapp2.RequestHandler):
    """
    https://github.com/giphy/GiphyAPI
    """

    def get(self):
        """
        Handle requests for giphy gif urls
        """
        limit = self.request.GET.get('limit', '100')
        offset = self.request.GET.get('offset', '0')
        rating = self.request.GET.get('rating', 'pg-13')  # y, g, pg, pg-13, r
        query = self.request.GET.get('q', 'funny dogs')
        api_key = 'dc6zaTOxFJmzC'

        query_string = urllib.urlencode({
            'q': query,
            'limit': limit,
            'offset': offset,
            'rating': rating,
            'api_key': api_key,
        })

        query_url = 'http://api.giphy.com/v1/gifs/search?{0}'.format(query_string)
        response = json.loads(urlopen(query_url).read())
        urls = [url['embed_url'] for url in response['data']]
        urls = '<br />'.join(urls)
        self.response.out.write(urls)