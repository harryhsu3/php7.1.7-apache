FROM php:7.1.7-apache

MAINTAINER Harry Hsu <harry@acom-networks.com>

RUN apt-get update && apt-get install -y libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) mcrypt mysqli
    && wget http://xdebug.org/files/xdebug-2.5.4.tgz -O /tmp/xdebug-2.5.4.tgz
    && cd /tmp/xdebug-2.5.4
    && phpize
    && ./configure
    && make
    && cp modules/xdebug.so /usr/local/lib/php/extensions/no-debug-non-zts-20160303
    && echo 'zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so' > php.ini

ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes
ENV MYSQL_DATABASE=newbouncer

EXPOSE 80
