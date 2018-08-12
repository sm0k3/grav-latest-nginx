FROM alpine:3.8
LABEL Maintainer="sm0k3 <sm0k3@svalbard.cf>" \
      Description="Lightweight GRAV CMS running on nginx with php-fpm."
VOLUME /srv/grav-data

# Install packages
RUN apk --no-cache add git php7 php7-fpm php7-mysqli php7-json php7-openssl php7-curl \
    php7-zlib php7-xml php7-phar php7-intl php7-dom php7-xmlreader php7-ctype \
    php7-mbstring php7-gd nginx supervisor curl

# Configure nginx
COPY config/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY config/fpm-pool.conf /etc/php7/php-fpm.d/zzz_custom.conf
COPY config/php.ini /etc/php7/conf.d/zzz_custom.ini

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#Add Files
COPY setup /tmp/setup
RUN sh /tmp/setup/filesetup.sh
RUN su - www-data -s /bin/bash -c 'bash /tmp/setup/setup.sh'
WORKDIR /var/www/html
EXPOSE 80 443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
