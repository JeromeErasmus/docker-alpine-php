FROM jeromeerasmus/docker-alpine-core

MAINTAINER Jerome Erasmus

ENV PHP_VERSION 5.5.35

CMD ["mkdir", "/tmp/php"]

ADD ./scripts/compile_php.sh /tmp/php/

RUN /bin/sh /tmp/php/compile_php.sh ${PHP_VERSION}

CMD ["/usr/bin/php"]

CMD  apk add openrc --no-cache
CMD  apk add --no-cache jq

# Add bash
CMD  apk add --no-cache py-pip bash 

# Add docker compose
CMD  pip install --no-cache-dir docker-compose