#!/bin/bash
set -e
apt-get update
apt-get install curl -y
apt-get autoremove -y --purge
apt-get clean
rm -rf /tmp/*
rm -rf /var/tmp/*
rm -rf /var/lib/apt/lists/* 