#!/bin/bash

set -e

args=("$@")

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
