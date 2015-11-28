REQUIREMENTS_INSTALLED := $(CURDIR)/.installed

SRCDIR = ./src/
GITHUB_URL = git@github.com:collective/

BRANCH=master

SRC_PACKAGES = $(wildcard $(SRCDIR)*)

PACKAGES = \
	collective.geo.geographer \
	collective.geo.openlayers \
	collective.geo.settings \
	collective.geo.mapwidget \
	collective.z3cform.mapwidget \
	collective.geo.behaviour \
	collective.geo.contentlocations \
	collective.geo.kml \
	collective.geo.usersmap


.PHONY: clone requirements update build bootstrap run stop destroy shell testall test

all: bootstrap run

$(PACKAGES):
	@if [ ! -d $(SRCDIR) ]; then mkdir $(SRCDIR); fi
	@if [ ! -d $(SRCDIR)$@ ]; then git -C $(SRCDIR) clone -b $(BRANCH) $(GITHUB_URL)$@.git ; fi \

collective.geo.openlayers: BRANCH=3.x
collective.geo.mapwidget: BRANCH=2.x


clone: requirements $(PACKAGES)


$(REQUIREMENTS_INSTALLED): requirements.txt
	@echo "Installing python-requirements..."
	pip install -U -r requirements.txt | grep --line-buffered -v '^   '

	@touch $@


requirements: $(REQUIREMENTS_INSTALLED)


update:
	@for pkg in $(SRC_PACKAGES) ; do \
		echo Update $$pkg ; \
		git -C $$pkg pull ; \
	done


build: update
	@docker-compose build --pull cgeo


bootstrap: clone build


run:
	@docker-compose run --rm --service-ports cgeo


stop:
	@docker-compose stop


destroy: stop
	@docker-compose rm -f


shell:
	@docker-compose run --rm --service-ports cgeo /bin/bash


testall:
	@docker-compose run --rm --service-ports cgeo testall


test:
ifdef PKG
	@docker-compose run --rm --service-ports cgeo test ${PKG}
else
	$(info USAGE: make test PKG=<package-to-test>)
	$(info Example: make test PKG=collective.geo.geographer)
	exit 0
endif
