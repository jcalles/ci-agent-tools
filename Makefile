tag = $(shell git rev-parse --short HEAD)

build:
	docker build -t buildpack:$(tag) .

tag:
	docker tag buildpack:$(tag) buildpack:local

run:
	docker run -it buildpack:$(tag) bash
