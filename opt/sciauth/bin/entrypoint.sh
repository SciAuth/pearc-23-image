#!/bin/sh
# Install materials for the tutorial.

set -eu

repository="${SCITOKENS_TUTORIAL_REPOSITORY:-}"

if [ -n "$repository" ]; then
  destination="$(basename -s .git -- "$repository")"
  (
    cd ~ \
    && rm -rf "$destination" \
    && git clone "$repository" "$destination" \
  )
fi

exec "$@"
