###############################################################################
# The build script for jeromeerasmus/docker-alpine-php image
#
# @image 		jeromeerasmus/docker-alpine-php
# @github 		https://github.com/jeromeerasmus/docker-alpine-php/
# @dockerhub 	https://hub.docker.com/r/jeromeerasmus/docker-alpine-php/
#
###############################################################################

# this uses the Alpine image to run the tests on
# to access the docker container you can use: docker run -it --rm -v ${PWD}:/home jeromeerasmus/docker-alpine-php-composer:7.0 /bin/sh
# or 
# docker run -it --rm jeromeerasmus/docker-alpine-php:7.0 /bin/bash

# config
IMAGE=jeromeerasmus/docker-alpine-php
DOCKER=`which docker`
SRC=`pwd`/src
PHP_55=5.5
PHP_56=5.6
PHP_70=7.0

# commands
php-5.5:
	@${DOCKER} build -f ${SRC}/${PHP_55}/Dockerfile -t ${IMAGE}:${PHP_55} ${SRC}/${PHP_55}/ --no-cache

php-5.6:
	@${DOCKER} build -f ${SRC}/${PHP_56}/Dockerfile -t ${IMAGE}:${PHP_56} ${SRC}/${PHP_56}/ --no-cache

php-7.0:
	@${DOCKER} build -f ${SRC}/${PHP_70}/Dockerfile -t ${IMAGE}:${PHP_70} ${SRC}/${PHP_70}/ --no-cache

build: php-5.5 php-5.6 php-7.0

all: build test

test:
	@sh tests/index.sh

.PHONY: clean

clean:
	@${DOCKER} rmi ${IMAGE}:${PHP_55}
	@${DOCKER} rmi ${IMAGE}:${PHP_56}
	@${DOCKER} rmi ${IMAGE}:${PHP_70}