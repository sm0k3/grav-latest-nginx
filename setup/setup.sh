#! /bin/bash
cd /var/www/grav
composer install --no-dev -o
bin/grav install
bin/gpm install admin
