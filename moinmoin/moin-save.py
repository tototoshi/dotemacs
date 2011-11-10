import sys

import client

argvs = sys.argv
argc = len(argvs)

c = client.Client()
c.login()
c.save_text(argvs[1], argvs[2])
