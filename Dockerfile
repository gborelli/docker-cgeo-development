FROM gborelli/plone-cgeo:5.0
MAINTAINER Giorgio Borelli <giorgio@giorgioborelli.it>

USER root

# Update buildout.cfg
COPY buildout.cfg buildout.cfg
COPY entrypoint.sh entrypoint.sh
COPY ./src src
RUN chown -R webapp:webapp buildout.cfg entrypoint.sh src

USER webapp

RUN python bin/buildout -v
CMD ["run"]
