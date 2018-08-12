#! /bin/bash
cd /var
git clone -b master https://github.com/getgrav/grav.git
mv /var/grav /var/www
chown -R www-data:www-data /var/www
cd /var/www
composer install --no-dev -o
bin/grav install
bin/gpm install admin
