FROM php:7.4-fpm-alpine

LABEL MAINTAINER="<crazyjums@gmail.com>"

ADD nginx-1.18.0.tar.gz /tmp
COPY nginx/ /tmp/

## isntall nginx by source code
WORKDIR /tmp/nginx-1.18.0

ENV TZ=Asia/Shanghai
RUN apk update && apk upgrade \
	&& apk add --no-cache --virtual .build-deps \
	g++ \
	pcre-dev \
	zlib-dev \
	make\
	gcc\
	libc-dev\
	autoconf \
	&& apk add pcre \
	tzdata \
	&& addgroup -S nginx\
	&& adduser -S -G nginx -s /sbin/nologin -h /usr/local/nginx nginx\
	&& ./configure --user=nginx --group=nginx --prefix=/usr/local/nginx\
	&& make\
	&& make install\
	&& mkdir -p /data/nginx/logs /data/nginx/logs /usr/local/nginx/conf/include \
	&& mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.back\
	&& mv /tmp/nginx.conf /usr/local/nginx/conf/nginx.conf\
	&& mv /tmp/include/localhost.conf /usr/local/nginx/conf/include/localhost.conf \
	&& mv /tmp/include/default.conf /usr/local/nginx/conf/include/default.conf \
    && mv /tmp/include/vuetest.conf /usr/local/nginx/conf/include/vuetest.conf \
	&& mv /tmp/html/php_nginx /usr/local/nginx/html/php_nginx \
	&& mv /tmp/html/vue_nginx /usr/local/nginx/html/vue_nginx \
	&& ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/ \
	&& /usr/local/nginx/sbin/nginx -t\
	&& ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
	&& echo 'install nginx success-------------ok'

## install php extensions
RUN pecl install -o -f yaf \
    && echo "extension=yaf.so" >> /usr/local/etc/php/conf.d/docker-php-ext-yaf.ini \
    && docker-php-ext-enable yaf \
    && echo 'install yaf success-------------ok'\
    && pecl install -o -f redis \
    && echo "extension=redis.so" >> /usr/local/etc/php/conf.d/docker-php-ext-redis.ini \
    && docker-php-ext-enable redis\
	&& echo 'install redis success-------------ok'\
	&& rm -rf /tmp/* \
	&& apk del .build-deps \
	&& echo '#!/bin/sh' >> /start.sh \
	&& echo 'php-fpm -D' >> /start.sh \
	&& echo 'nginx' >> /start.sh \
	&& echo '/bin/sh' >> /start.sh

EXPOSE 80 443

ENTRYPOINT ["/bin/sh", "/start.sh"]