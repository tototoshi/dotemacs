import sys

import client

if __name__ == '__main__':
    argvs = sys.argv
    url = argvs[1]
    pagename = argvs[2]
    c = client.Client(url)
    c.login()
    c.get_text(pagename)
