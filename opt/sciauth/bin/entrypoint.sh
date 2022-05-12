#!/bin/sh
# Prepare the host before starting the notebook server.

set -eu

if [ -n "${SCIAUTH_TUTORIAL_REPOSITORY:-}" ]; then
  (cd ~ && git clone "${SCIAUTH_TUTORIAL_REPOSITORY}")
fi

exec "$@"
