#!/bin/bash

#Hack!
# I can't figure out how to start rqt in a venv
# (using rosrun rqt_gui rqt_gui)
# It fails due to missing dependencies, but I can't figure out
# what needs to be installed.
# Anyway, calling 'rqt' at the command line still works, because
# the system installed 'rqt' hard-codes to use system python, not
# the venv. 
# So I've made this script, which just calls that system rqt, which
# should work even in a venv.
# Ideal resolution - find which pip deps need to be installed to make
# it work via rosrun.

rqt "$@"