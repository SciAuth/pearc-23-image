#!/bin/sh
# Prepare the host before starting the notebook server.

set -eu

repository="${SCIAUTH_TUTORIAL_REPOSITORY:-}"

if [ -n "$repository" ]; then
  destination="$(basename -s .git -- "$repository")"
  (
    cd ~ \
    && rm -rf "$destination" \
    && git clone "$repository" "$destination" \
  )
fi

exec "$@"
