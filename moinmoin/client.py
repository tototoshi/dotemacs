import os
import urllib
import cookielib
import urllib2
import BeautifulSoup
import htmlentitydefs
import re

class MoinMoinError(Exception):
    """Base class for exceptions in this module."""
    pass

class Client():
    """
    """
    base_url = "http://ttoshi.me/wiki"

    def __init__(self):
        rcfile = os.path.join(os.getenv("HOME"), ".moinrc")

        f = open(rcfile)
        self.username, self.password = f.read().strip().split(':')
        f.close()

        # Basic Auth
        passman = urllib2.HTTPPasswordMgrWithDefaultRealm()
        passman.add_password(None, self.base_url, self.username, self.password)

        # Cookie
        cj = cookielib.CookieJar()

        authhandler = urllib2.HTTPBasicAuthHandler(passman)
        cookiehandler = urllib2.HTTPCookieProcessor(cj)
        opener = urllib2.build_opener(authhandler, cookiehandler)
        urllib2.install_opener(opener)

    def GET(self, page_name):
        """

        Arguments:
        - `path`:
        """

        url = self.base_url + "/" + page_name
        response = urllib2.urlopen(url)
        the_page = response.read()
        return the_page


    def POST(self, page_name, values):
        """POST

        Arguments:
        - `page_name`:
        - `data`:
        """
        url = self.base_url + "/" + page_name
        data = urllib.urlencode(dict([k.encode('utf-8'),unicode(v).encode('utf-8')] for k,v in values.items()))
        req = urllib2.Request(url, data)
        response = urllib2.urlopen(req)
        the_page = response.read()
        return the_page

    def get_top_page(self):
        self.GET("toppage")

    def get_page(self, pagename):
        """

        Arguments:
        - `pagename`:
        """
        self.GET(pagename)

    def login(self, user="toshi", password="password"):
        """login

        Arguments:
        - `user`:
        - `password`:
        """
        loginpath = "/?action=login"
        values = {"name": self.username,
                  "password": self.password,
                  "login": "Login"}

        self.POST(loginpath, values)

    def get_text(self, pagename):
        """

        Arguments:
        - `pagename`:
        """
        page = self.GET(pagename + "?action=edit&editor=text")
        soup = BeautifulSoup.BeautifulSoup(page)
        re
        print self.HTMLEntitiesToUnicode(soup.find("textarea").string)

    def save_text(self, pagename, filename):
        page = self.GET(pagename + "?action=edit&editor=text")
        soup = BeautifulSoup.BeautifulSoup(page)
        rev = soup.find("input", {"name": "rev"})['value']
        ticket = soup.find("input", {"name": "ticket"})['value']

        import codecs
        data = u''
        with codecs.open(filename, 'r', 'utf-8') as f:
            for line in f:
                data += line

        values = {
            'action': 'edit',
            'rev': rev,
            'ticket': ticket,
            'button_save': 'Save+Changes',
            'editor': 'text',
            'savetext': data,
            'comment': '',
            'category': '',
        }

        self.POST(pagename, values)

    def HTMLEntitiesToUnicode(self, text):
        """Converts HTML entities to unicode.  For example '&amp;' becomes '&'."""
        text = BeautifulSoup.BeautifulStoneSoup(text, convertEntities=BeautifulSoup.BeautifulStoneSoup.ALL_ENTITIES)
        return text
