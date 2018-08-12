#! /bin/bash
cd /var/www/grav
COMPOSER_ALLOW_SUPERUSER=1 php composer install --no-dev -o
bin/grav install
bin/gpm install admin
