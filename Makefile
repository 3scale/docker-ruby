REPO=ruby
REGISTRY:=quay.io/3scale
TAG:=$(shell git rev-parse --abbrev-ref HEAD)
IMAGE:=$(REGISTRY)/$(REPO):$(TAG)

build:
	docker build -t $(IMAGE) --rm .

bash:
	docker run --rm -t -i $(IMAGE) bash
release: build push

push:
	docker push $(IMAGE)
