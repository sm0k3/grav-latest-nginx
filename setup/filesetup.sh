#! /bin/bash
cd /tmp
git clone -b master https://github.com/getgrav/grav.git
mv ./grav/user /srv/grav-data/user
chown -R www-data:www-data /srv/grav-data/*
mv ./grav /var/www/grav
ln -s /srv/grav-data/user /var/www/grav/user
chown -R www-data:www-data /var/www/*
su - www-data -s /bin/bash -c 'bash /tmp/setup/setup.sh'