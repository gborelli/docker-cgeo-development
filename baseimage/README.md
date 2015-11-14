# Overview

Base image for Plone Maps - collective.geo.

It creates a simple Plone site with collective.geo packages installed
and some demo contents.


# Usage:

You can try the latest Plone Maps version by using this command::

    docker run --name cgeo -p 8080:8080 gborelli/cgeo:latest

and point your browser to::

    http://<docker_ip>:8080/Plone


# Plone administrator user

* username: admin
* password: admin
