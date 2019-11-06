#!/bin/bash
set -e

if [[ ! -f "${ADMIN_RUN}/prepare_app.log" ]]; then
    echo "Prepare App... [`date`]"
    # sleep ${PREPARE_SLEEP}
    /prepare_app.sh
    echo "ok: `date`" > ${ADMIN_RUN}/prepare_app.log
    echo "Prepare Finished. [`date`]"
fi

echo "################################################################################################"
echo "#                                                                                              #"
echo "#                                   Start Application                                          #"
echo "#                                                                                              #"
echo "################################################################################################"

echo "Starting application..."
echo "do something..." && bash