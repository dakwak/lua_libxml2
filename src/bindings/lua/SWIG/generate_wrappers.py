#!/usr/bin/env python

import sys
import os

os.chdir(sys.argv[1] or ".")

args = ['-Wall', '-lua']

os.system("swig %s -Ipackages -o wrappers/lua_libxml2_wrap.cxx packages/lua_libxml2.i" % ' '.join(args))
