#!/bin/bash
set -e

if [[ ! -f "${ADMIN_RUN}/run_on_first_startup.log" ]]; then
    echo EXEC: /admin_startup/run_on_first_startup.sh
    /admin_startup/run_on_first_startup.sh
    echo "ok: `date`" >> ${ADMIN_RUN}/run_on_first_startup.log
fi

echo EXEC: /admin_startup/run_on_startup.sh
/admin_startup/run_on_startup.sh

echo start services ...
echo "################################################################################################"
# exec /bin/tini -- /usr/sbin/sshd -D
/usr/sbin/sshd -D &
if [[ ${CMD_USER} == "root" ]]; then
    if [[ -n "$@" ]]; then
        /usr/bin/supervisord &
        echo "$@"
        $@
    else
        /usr/bin/supervisord
    fi
else
    if [[ -n "$@" ]]; then
        su ${SUDOER_USER} -c /usr/bin/supervisord &
        echo su ${CMD_USER} -c "$@"
        su ${CMD_USER} -c "$@"
    else
        su ${SUDOER_USER} -c /usr/bin/supervisord
    fi

fi