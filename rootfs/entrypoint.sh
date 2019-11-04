#!/bin/bash
set -e

if [[ ! -f "${ADMIN_RUN_DATA}/run_on_first_startup.log" ]]; then
    echo EXEC: /admin_startup/run_on_first_startup.sh
    /admin_startup/run_on_first_startup.sh
    echo "`date`" >> ${ADMIN_RUN_DATA}/run_on_first_startup.log
fi

echo EXEC: /admin_startup/run_on_startup.sh
/admin_startup/run_on_startup.sh

# echo "start run startup scripts..."
# sudo chmod +x /startup_scripts/*.sh
# for var in $(ls /startup_scripts/*.sh)
# do
#     echo "$var"
#     $var
# done
# echo "run startup scripts finished."

# echo "Replace id_rsa if exists by -v /your/id_rsa/dir:/ssh_id_rsa"
# if [[ -f "${SSH_ID_RSA_DIR}/id_rsa" ]]; then
#     sudo cp -f ${SSH_ID_RSA_DIR}/id_rsa /root/.ssh/id_rsa
#     sudo chmod 600 /root/.ssh/id_rsa
# fi

# echo "Replace id_rsa.pub if exists by -v /your/id_rsa/dir:/ssh_id_rsa"
# if [[ -f "${SSH_ID_RSA_DIR}/id_rsa.pub" ]]; then
#     sudo cp -f ${SSH_ID_RSA_DIR}/id_rsa.pub /root/.ssh/id_rsa.pub
# fi

# echo "Replace id_rsa.pub if exists by -v /your/id_rsa/dir:/ssh_id_rsa"
# if [[ -f "${SSH_ID_RSA_DIR}/authorized_keys" ]]; then
#     sudo cp -f ${SSH_ID_RSA_DIR}/authorized_keys /root/.ssh/authorized_keys
#     sudo chmod 600 /root/.ssh/authorized_keys
# fi

echo start services ...
echo "################################################################################################"
/usr/bin/supervisord
echo $@
$@