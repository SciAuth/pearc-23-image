#!/bin/sh

cat >/etc/apache2/envvars <<EOF

# Configure Apache to run as 'jovyan'.

export APACHE_RUN_USER=jovyan
export APACHE_RUN_GROUP=users

export APACHE_PID_FILE=/apache2-jovyan/run/apache2.pid
export APACHE_RUN_DIR=/apache2-jovyan/run/
export APACHE_LOCK_DIR=/apache2-jovyan/lock/
export APACHE_LOG_DIR=/apache2-jovyan/log/
EOF
