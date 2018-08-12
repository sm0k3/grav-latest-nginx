#! /bin/bash
cd /var/www/html
COMPOSER_ALLOW_SUPERUSER=1 php composer install --no-dev -o
bin/grav install
bin/gpm install admin
