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


    def __init__(self, base_url):
        rcfile = os.path.join(os.getenv("HOME"), ".moinrc")

        self.base_url = base_url

        p = re.compile('(https?://)(.*?):(.*?)@(.*?)$')
        m = p.match(base_url)
        if m:
            basic_auth_user = m.group(2)
            basic_auth_password = m.group(3)
            self.base_url = m.group(1) + m.group(4)

        f = open(rcfile)
        self.username, self.password = f.read().strip().split(':')
        f.close()

        # Basic Auth
        passman = urllib2.HTTPPasswordMgrWithDefaultRealm()
        passman.add_password(None, self.base_url, basic_auth_user, basic_auth_password)

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

    def login(self):
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
