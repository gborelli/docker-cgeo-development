FROM abstracttechnology/plone:4.3
MAINTAINER Giorgio Borelli <giorgio@giorgioborelli.it>

USER root

# Update buildout.cfg
COPY buildout.cfg buildout.cfg

RUN chown -R webapp:webapp buildout.cfg

USER webapp
RUN python bin/buildout -v
