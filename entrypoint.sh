#!/bin/bash

set -e

args=("$@")

# Compile egg-info directory for each package in src directory
if [ -d ./src ]; then
    for pkj in src/*; do ( cd $pkj && if [ ! -d $pkj.egg-info ]; then python setup.py egg_info; fi  ) done
fi


case $1 in
    demo)
        cp -r data/* var
        /srv/webapp/bin/instance fg
        ;;
    run)
        /srv/webapp/bin/instance fg
        ;;
    testall)
        /srv/webapp/bin/test-all
        ;;
    test)
        /srv/webapp/bin/test -s ${args[@]:1}
        ;;
    *)
        exec "$@"
        ;;
esac
