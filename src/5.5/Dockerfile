FROM jeromeerasmus/docker-alpine-core

MAINTAINER Jerome Erasmus

ENV PHP_VERSION 5.5.35

CMD ["mkdir", "/tmp/php"]

ADD ./scripts/compile_php.sh /tmp/php/

RUN /bin/sh /tmp/php/compile_php.sh ${PHP_VERSION}

CMD ["/usr/bin/php"]

