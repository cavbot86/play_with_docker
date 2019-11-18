#!/bin/bash
set -e

if [[ ! -f "${ADMIN_RUN}/run_on_first_startup.log" ]]; then
    echo EXEC: /admin_startup/run_on_first_startup.sh
    /admin_startup/run_on_first_startup.sh
    echo "ok: `date`" >> ${ADMIN_RUN}/run_on_first_startup.log
fi

echo EXEC: /admin_startup/run_on_startup.sh
/admin_startup/run_on_startup.sh

/admin_install/init_permission.sh

if [[ -e "${WORKSPACE}/root_exec.sh" ]]; then
    bash ${WORKSPACE}/root_exec.sh
fi

echo start services ...
echo "################################################################################################"
# exec /bin/tini -- /usr/sbin/sshd -D
/usr/sbin/sshd -D &
if [[ ${CMD_USER} == "root" ]]; then
    echo "$@"
    $@
else
    echo su ${CMD_USER} -c "$@"
    su ${CMD_USER} -c "$@"
fi