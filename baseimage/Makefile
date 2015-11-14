all: run

build:
	@docker-compose build --pull cgeo


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

.PHONY: build run stop destroy shell testall test
