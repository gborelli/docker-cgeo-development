all: run

build:
	docker-compose build plone

run:
	docker-compose run --rm --service-ports  plone

.PHONY: run build
