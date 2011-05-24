import os
import sys

def flatten(xs):
    xs_new = []
    for x in xs:
        xs_new = xs_new + x
    return xs_new

def format(el):
    return """(load "%s")""" % el

emacsd = os.path.join(os.getenv("HOME"), ".emacs.d")

my_el_dir = [os.path.join(emacsd, "dotemacs"),
             os.path.join(emacsd, "dotemacs", "util"),
             os.path.join(emacsd, "dotemacs", "myphp")]

my_files = flatten([os.listdir(d) for d in my_el_dir])

for f in my_files:
    if f[-3:] == ".el":
        print format(f)

