FROM gborelli/plone-cgeo:4.3
MAINTAINER Giorgio Borelli <giorgio@giorgioborelli.it>

USER root

# Install some packages
RUN apt-get update && \
    apt-get install -y  vim screen && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*



# Update buildout.cfg
COPY buildout.cfg buildout.cfg
COPY entrypoint.sh entrypoint.sh
COPY ./src src
RUN chown -R webapp:webapp buildout.cfg entrypoint.sh src

USER webapp

RUN python bin/buildout -v
ENTRYPOINT ["./entrypoint.sh"]
