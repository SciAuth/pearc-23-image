#!/bin/sh
# Prepare the host before starting the notebook server.

set -eu

if [ -n "${TUTORIAL_REPOSITORY:-}" ]; then
  (cd ~ && git clone "${TUTORIAL_REPOSITORY}")
fi

exec "$@"
