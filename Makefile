#!/usr/bin/env make -f

SHELL := /bin/bash

APP := helloworld
PROJECT := burdz/helloworld
MAJOR_VERSION := 0
MINOR_VERSION := 0
PATCH_VERSION := 1
VERSION = $(MAJOR_VERSION).$(MINOR_VERSION).$(PATCH_VERSION)
HAS_GOMETALINTER := $(shell command -v gometalinter;)

default: all

.PHONY: all
all: clean fmt vet test bootstrap lint build push helm-package

.PHONY: clean
clean: 
		rm -rf *.tgz

.PHONY: fmt
fmt:
		go fmt ./...

.PHONY: vet
vet:
		go vet ./...

.PHONY: test
test: 
		go test -v ./...

.PHONY: lint
lint:
		gometalinter --install --update
		gometalinter          \
		--enable-gc           \
		--deadline 40s        \
		--exclude bindata     \
		--exclude .pb.        \
		--exclude vendor      \
		--skip vendor         \
		--disable-all         \
		--enable=errcheck     \
		--enable=goconst      \
		--enable=gofmt        \
		--enable=golint       \
		--enable=gosimple     \
		--enable=ineffassign  \
		--enable=gotype       \
		--enable=misspell     \
		--enable=vet          \
		--enable=vetshadow    \
		./main.go

.PHONY: build
build:
		docker build --rm -t $(PROJECT) .
		docker tag burdz/helloworld burdz/helloworld:$(VERSION)

.PHONY: push
push:
		docker push $(PROJECT)

.PHONY: helm-package
helm-package:
		helm package --version $(VERSION) deploy/$(APP)

.PHONY: helm-deploy
helm-deploy:
		helm install $(APP)-$(VERSION).tgz

.PHONY: bootstrap
bootstrap:
ifndef HAS_GOMETALINTER
		go get -u github.com/alecthomas/gometalinter
endif
