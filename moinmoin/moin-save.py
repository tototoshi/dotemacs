import sys

import client

argvs = sys.argv
argc = len(argvs)

c = client.Client(argvs[1])
c.login()
c.save_text(argvs[2], argvs[3])
