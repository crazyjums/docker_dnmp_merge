FROM alpine

LABEL MAINTAINER="<crazyjums@gmail.com>"

ADD nginx-1.18.0.tar.gz /tmp
COPY nginx/nginx.conf /tmp/nginx.conf
COPY start.sh /tmp/start.sh

## isntall nginx by source code
WORKDIR /tmp/nginx-1.18.0

RUN apk update && apk upgrade\
	&& apk add --no-cache --virtual .build-deps \
	mlocate \
	g++ \
	pcre-dev \
	zlib-dev \
	make\
	gcc\
	libc-dev\
	libxml2-dev\
	autoconf \
	&& apk add pcre\
	&& apk add sqlite-dev \
	&& addgroup -S nginx\
	&& adduser -S -G nginx -s /sbin/nologin -h /usr/local/nginx nginx\
	&& ./configure --user=nginx --group=nginx --prefix=/usr/local/nginx\
	&& make\
	&& make install\
	&& mkdir -p /data/nginx/logs /data/nginx/logs\
	&& mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.back\
	&& mv /tmp/nginx.conf /usr/local/nginx/conf/nginx.conf\
	&& mv /tmp/start.sh /start.sh\
	&& rm -rf /tmp/*\
	&& ln -s /usr/local/nginx/sbin/nginx /usr/local/bin/ \
	&& /usr/local/nginx/sbin/nginx -t
	
## install php(enable-fpm) by sourece code
ADD php-7.4.27.tar.gz /tmp
COPY php/php-fpm.conf /tmp/php-fpm.conf
COPY php/php-fpm.d/www.conf /tmp/www.conf

WORKDIR /tmp/php-7.4.27

RUN ./configure --prefix=/usr/local/php --enable-fpm\
	&& make \
	&& make install \
	# && make test \
	&& mv /tmp/php-fpm.conf /usr/local/php/etc/php-fpm.conf \
	&& mv /tmp/www.conf /usr/local/php/etc/php-fpm.d/www.conf \
	&& /usr/local/php/sbin/php-fpm /usr/local/bin/ \
	&& apk del .build-deps

EXPOSE 80 443

ENTRYPOINT ["/bin/sh","/start.sh"]