FROM alpine:3.8
LABEL Maintainer="sm0k3 <sm0k3@svalbard.cf>" \
      Description="Lightweight GRAV CMS running on nginx with php-fpm."
VOLUME /srv/grav-data

# Install packages
RUN apk --no-cache add git php7 php7-fpm php7-zip php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype \
    php7-mbstring php7-gd php7-session php7-simplexml php7-yaml php7-opcache php7-apcu nginx supervisor curl

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN curl -sS https://getcomposer.org/installer | php && mv -f composer.phar /bin/composer
#Add Files
COPY setup/setup.sh /srv/setup.sh
RUN sh /srv/setup.sh
WORKDIR /var/www/html
EXPOSE 80 443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
