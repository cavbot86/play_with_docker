#!/bin/bash
set -e

if [[ ! -f "/prepare_app.log" ]]; then
    echo "Prepare App..."
    # sleep ${PREPARE_SLEEP}
    /prepare_app.sh
    echo "Prepare Finished."
fi

echo "################################################################################################"
echo "#                                                                                              #"
echo "#                                   Start Application                                          #"
echo "#                                                                                              #"
echo "################################################################################################"

echo "Starting application..."
echo "do something..." && bash