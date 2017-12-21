SHELL := /bin/bash

CONTAINER_URL = naamio/arvostelu:0.0
CONTAINER_NAME = arvostelu

clean:
	if	[ -d ".build" ]; then \
		rm -rf .build ; \
	fi

build: clean
	@echo --- Building Lasku
	swift build

test: build
	swift test

run: build
	@echo --- Invoking Arvostelu executable
	./.build/debug/Arvostelu

build-release: clean
	docker run -v $$(pwd):/tmp/arvostelu -w /tmp/arvostelu -it ibmcom/swift-ubuntu:4.0 swift build -c release -Xcc -fblocks -Xlinker -L/usr/local/lib -Xswiftc -whole-module-optimization

clean-container:

	-docker stop $(CONTAINER_NAME)
	-docker rm $(CONTAINER_NAME)
	-docker rmi $(CONTAINER_URL)

build-container: clean-container build-release

	docker build -t $(CONTAINER_URL) .

.PHONY: build test run
