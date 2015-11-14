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
    *)
        exec "$@"
        ;;
esac