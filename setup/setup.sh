#! /bin/bash

#Config Opts Down change these unless you know what your doing
WEBUSER="nginx"
WEBGROUP="nginx"
PersistantDIR="/srv/grav-data"
WEBDIR="/var/www/html"
RUNFILE="$PersistantDIR/user/.run"

#END Config Opts
cd $WEBDIR
echo "~~ Install Grav Core Files"
COMPOSER_ALLOW_SUPERUSER=1 composer create-project getgrav/grav /var/www/html &>/dev/null
echo "Checking Persistance"
if [ ! -f "${RUNFILE}" ]
then
    echo "File ${RUNFILE} does not exist"
    echo "First run moving grav userfolder to persistant volume" 
    mv ./user ${PersistantDIR}/user
    echo "DO NOT DELETE" > ${RUNFILE}
    echo "linking Grav user folder to Persistance Volume"
    ln -sfn ${PersistantDIR}/user ${WEBDIR}/user
fi
if [[ -d "${WEBDIR}/user" && ! -L "${WEBDIR}/user" ]]
then
    echo "Grav user dir exists and is not a symbolic link Deleting"
    rm -fr ${WEBDIR}/user
    echo "linking Grav user folder to Persistance Volume"
    ln -sfn ${PersistantDIR}/user ${WEBDIR}/user
fi
echo "fixing permissions in ${WEBDIR}"
find ${WEBDIR} -exec chown ${WEBUSER}:${WEBGROUP} {} \;
find ${WEBDIR} -type d -exec chmod 755 {} \;
find ${WEBDIR} -type f -exec chmod 644 {} \;
echo "fixing permissions in ${PersistantDIR}/user"
find ${WEBDIR}/user -exec chown -RL ${WEBGROUP}:${WEBGROUP} {} \;
find ${WEBDIR}/user -type d -exec chmod 775 {} \;
find ${WEBDIR}/user -type f -exec chmod 664 {} \;
echo "installing Grav"
bin/grav install -n &>/dev/null
echo "installing Admin Plugin"
bin/gpm install admin -y >/dev/null