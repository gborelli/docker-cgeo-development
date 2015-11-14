REQUIREMENTS_INSTALLED := $(CURDIR)/.installed

.PHONY: requirements update build bootstrap run stop destroy shell testall test

all: run

$(REQUIREMENTS_INSTALLED): requirements.txt
	@echo "Installing python-requirements..."
	pip install --upgrade pip
	pip install -U -r requirements.txt | grep --line-buffered -v '^   '

	@touch $@


requirements: $(REQUIREMENTS_INSTALLED)


update: requirements
	git submodule init
	git submodule update


build:
	@docker-compose build --pull cgeo


bootstrap: update build


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


