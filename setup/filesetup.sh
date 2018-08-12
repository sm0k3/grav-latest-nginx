#! /bin/bash
cd /tmp
git clone -b master https://github.com/getgrav/grav.git
mv ./grav/user /srv/grav-data/user
mv ./grav /var/www/html
ln -s /srv/grav-data/user /var/www/html/user
