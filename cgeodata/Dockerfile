FROM busybox:latest
MAINTAINER Giorgio Borelli <giorgio@giorgioborelli.it>

RUN mkdir -p /srv/webapp/var/filestorage /srv/webapp/var/blobstorage /srv/webapp/var/log
RUN adduser -u 1000 -h /srv/webapp -s /usr/sbin/nologin -D webapp

RUN chown -R webapp:webapp /srv/webapp/

VOLUME ["/srv/webapp/var/filestorage", "/srv/webapp/var/blobstorage", "/srv/webapp/var/log"]

USER webapp

CMD ["/bin/ash"]
