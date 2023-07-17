# shellcheck shell=sh
# This script is written so that it may be 'source'ed.

if [ "$(whoami)" = "jovyan" ]; then
  _demo_target="${HOME}/work/PEARC23-SciAuth-Tutorial"
else
  _demo_target="${HOME}/PEARC23-SciAuth-Tutorial"
fi


# Initialize the directory for the demo.
# Try to be polite and not overwrite existing data.

if [ ! -e "${_demo_target}" ]; then
  mkdir -p "${_demo_target}"
  cp -r /demo-init.d/* "${_demo_target}"
fi
