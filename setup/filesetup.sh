#! /bin/bash
cd /tmp
git clone -b master https://github.com/getgrav/grav.git
mv ./grav/user /srv/grav-data/user
chown -R www-data:www-data /srv/grav-data/*
mv ./grav /var/www/html
ln -s /srv/grav-data/user /var/www/html/user
chown -R www-data:www-data /var/www/*