FROM gborelli/cgeo:4.3
MAINTAINER Giorgio Borelli <giorgio@giorgioborelli.it>

USER root

# Update buildout.cfg
COPY buildout.cfg buildout.cfg
COPY entrypoint.sh entrypoint.sh
RUN chown -R webapp:webapp buildout.cfg entrypoint.sh

USER webapp

RUN python bin/buildout -v
ENTRYPOINT ["./entrypoint.sh"]
