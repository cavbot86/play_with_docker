#!/bin/bash
set -e

if [[ ! -f "${ADMIN_RUN_DATA}/run_on_first_startup.log" ]]; then
    echo EXEC: /admin_startup/run_on_first_startup.sh
    /admin_startup/run_on_first_startup.sh
    echo "ok: `date`" >> ${ADMIN_RUN_DATA}/run_on_first_startup.log
fi

echo EXEC: /admin_startup/run_on_startup.sh
/admin_startup/run_on_startup.sh

echo start services ...
echo "################################################################################################"
# exec /bin/tini -- /usr/sbin/sshd -D
/usr/sbin/sshd -D &
su ${SUDOER_USER} -c /usr/bin/supervisord
echo su ${SUDOER_USER} -c "$@"
su ${SUDOER_USER} -c "$@"