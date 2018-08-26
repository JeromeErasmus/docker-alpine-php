#!/bin/sh

# core utils
CORE_UTILS="git grep zlib tar make libxml2 readline freetype openssl libjpeg-turbo libpng libmcrypt libwebp icu"

# build deps
BUILD_DEPS="build-base re2c file readline-dev autoconf binutils bison libxml2-dev curl-dev freetype-dev openssl-dev libjpeg-turbo-dev libpng-dev libwebp-dev libmcrypt-dev gmp-dev icu-dev libmemcached-dev"

# default, PHP 7.0.2 fallback
PHP_VERSION=${1:-"7.0.6"}

# add packages
apk add ${CORE_UTILS} ${BUILD_DEPS}

# go to working dir
cd /tmp/php

# get the php source package
wget https://github.com/php/php-src/archive/php-${PHP_VERSION}.tar.gz
tar xzf php-${PHP_VERSION}.tar.gz
cd php-src-php-${PHP_VERSION}

#add Auto conf
apk add autoconf

apk add build-base

# compile & build
./buildconf --force

./configure \
        --prefix=/usr \
        --sysconfdir=/etc/php \
        --with-config-file-path=/etc/php \
        --with-config-file-scan-dir=/etc/php/conf.d \
        --enable-fpm --with-fpm-user=root --with-fpm-group=root \
        --enable-cli \
        --enable-mbstring \
        --enable-zip \
        --enable-ftp \
        --enable-bcmath \
        --enable-opcache \
        --enable-pcntl \
        --enable-mysqlnd \
        --enable-gd-native-ttf \
        --enable-sockets \
        --enable-exif \
        --enable-soap \
        --enable-calendar \
        --enable-intl \
        --enable-json \
        --enable-dom \
        --enable-libxml --with-libxml-dir=/usr \
        --enable-xml \
        --enable-xmlreader \
        --enable-phar \
        --enable-session \
        --enable-sysvmsg \
        --enable-sysvsem \
        --enable-sysvshm \
        --disable-cgi \
        --disable-debug \
        --disable-rpath \
        --disable-static \
        --disable-phpdbg \
        --with-libdir=/lib/x86_64-linux-gnu \
        --with-curl \
        --with-mcrypt \
        --with-iconv \
        --with-gd --with-jpeg-dir=/usr --with-webp-dir=/usr --with-png-dir=/usr \
        --with-freetype-dir=/usr \
        --with-zlib --with-zlib-dir=/usr \
        --with-openssl \
        --with-mhash \
        --with-pcre-regex \
        --with-pdo-mysql \
        --with-mysqli \
        --with-readline \
        --with-xmlrpc \
        --with-pear

# make
make
make install
make clean

# reduce binary size
strip -s /usr/bin/php

# remove cache and build deps
cd /
apk del ${BUILD_DEPS}
rm -rf /var/cache/apk/*
rm -rf /tmp/*