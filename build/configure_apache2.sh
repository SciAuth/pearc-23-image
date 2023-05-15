#!/bin/sh
# Configure Apache to run as 'jovyan'.

set -eu


## Create Apache's runtime directories in 'jovyan's home directory.


RUNTIME_DIR="/home/${NB_USER}/.apache2"

APACHE_PID_FILE="${RUNTIME_DIR}/run/apache2.pid"
APACHE_RUN_DIR="${RUNTIME_DIR}/run/"
APACHE_LOCK_DIR="${RUNTIME_DIR}/lock/"
APACHE_LOG_DIR="${RUNTIME_DIR}/log/"

mkdir -p "${APACHE_RUN_DIR}" "${APACHE_LOCK_DIR}" "${APACHE_LOG_DIR}"
chown -R "${NB_UID}:${NB_GID}" "${RUNTIME_DIR}"


## Set the environment variables used by 'apachectl' and friends.


cat >>/etc/apache2/envvars <<EOF

# Configure Apache to run as 'jovyan'.

export APACHE_RUN_USER="${NB_USER}"
export APACHE_RUN_GROUP="users"

export APACHE_PID_FILE="${APACHE_PID_FILE}"
export APACHE_RUN_DIR="${APACHE_RUN_DIR}"
export APACHE_LOCK_DIR="${APACHE_LOCK_DIR}"
export APACHE_LOG_DIR="${APACHE_LOG_DIR}"
EOF
