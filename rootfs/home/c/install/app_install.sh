#!/bin/bash
set -e
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
apt-get update
apt-get install git -y
apt-get autoremove -y --purge
apt-get clean
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -rf /var/lib/apt/lists/* 