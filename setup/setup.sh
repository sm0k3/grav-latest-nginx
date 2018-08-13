#! /bin/bash
mkdir -p /var/www/html
cd /var/www/html
echo "Create GRAV Files...."
COMPOSER_ALLOW_SUPERUSER=1 composer create-project getgrav/grav /var/www/html &>/dev/null
GFILE="/srv/grav-data/user/.run"
GDIR="/var/www/html/user"
if [ ! -f "$GFILE" ]
then
    echo "File $GFILE does not exist"
    echo "First run moving grav userfolder to persistant volume" 
    mv ./user /srv/grav-data/user
    echo "DO NOT DELETE" > /srv/grav-data/user/.run
fi
if [[ -d "$GDIR" && ! -L "$GDIR" ]]
then
    echo "Grav user Dir exists and is not a symbolic link Deleting"
    rm -fr $GDIR
fi
echo "linking Grav Userfolder to Volume"
ln -s /var/www/html/user /srv/grav-data/user
echo "installing Grav"
bin/grav install -n >/dev/null
echo "installing Admin Plugin"
bin/gpm install admin -y >/dev/null