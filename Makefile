REQUIREMENTS_INSTALLED := $(CURDIR)/.installed

DOCKER_PRJ = cgeo
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
	collective.z3cform.colorpicker \
	collective.geo.behaviour \
	collective.geo.kml \
	collective.geo.usersmap


.PHONY: clone requirements update build bootstrap run stop destroy shell testall test

all: bootstrap run

$(PACKAGES):
	@if [ ! -d $(SRCDIR) ]; then mkdir $(SRCDIR); fi
	@if [ ! -d $(SRCDIR)$@ ]; then git -C $(SRCDIR) clone -b $(BRANCH) $(GITHUB_URL)$@.git ; fi \


# NOTE: example to change branch for some package
# <package.name>: BRANCH=<branch name>
# collective.geo.mapwidget: BRANCH=2.x


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
	@docker-compose build --pull $(DOCKER_PRJ)


bootstrap: clone build


run:
	@docker-compose run --rm --service-ports $(DOCKER_PRJ)


stop:
	@docker-compose stop


destroy: stop
	@docker-compose rm -f -v


shell:
	@docker-compose run --rm --service-ports $(DOCKER_PRJ) /bin/bash


testall:
	@docker-compose run --rm --service-ports $(DOCKER_PRJ) testall


test:
ifdef PKG
	@docker-compose run --rm --service-ports $(DOCKER_PRJ) test ${PKG}
else
	$(info USAGE: make test PKG=<package-to-test>)
	$(info Example: make test PKG=collective.geo.geographer)
	exit 0
endif
