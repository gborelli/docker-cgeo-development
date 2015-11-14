all: run

build:
	@docker-compose build cgeo

run:
	@docker-compose run --rm --service-ports cgeo

testall:
	@docker-compose run --rm --service-ports cgeo testall

shell:
	@docker-compose run --rm --service-ports cgeo /bin/bash

stop:
	@docker-compose stop


destroy: stop
	@docker-compose rm -f


.PHONY: run build shell stop destroy