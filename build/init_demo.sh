#!/bin/bash
# Initialize the directory for the demo.

shopt -s nullglob


## The destination depends on who we are.


if [ "$(whoami)" = "jovyan" ]; then
  target="${HOME}/work/PEARC23-SciAuth-Tutorial"
else
  target="${HOME}/PEARC23-SciAuth-Tutorial"
fi


## Copy files. By default, overwrite the destination.


mkdir -p "${target}"

for src in /demo-init.d/*; do
  dst="${target}/$(basename -- "${src}")"

  if [ -z "${1}" ]
  then
    rm -rf "${dst}"
  fi

  if [ ! -e "${dst}" ]
  then
    cp -r "${src}" "${dst}"
  fi
done
