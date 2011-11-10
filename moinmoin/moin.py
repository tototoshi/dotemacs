import sys

import client

if __name__ == '__main__':
    argvs = sys.argv
    argc = len(argvs)

    c = client.Client()
    c.login()
    pagename = argvs[1]
    c.get_text(pagename)
