#!/bin/sh
# Create a single self-signed certificate for all services that we wish to
# run in this container. It is somewhat simpler to accept or trust one such
# certificate rather than many.

THIS_DIR="$(cd -- "$(dirname -- "$0")" && pwd)"

openssl req -x509 \
  -subj "/CN=localhost" \
  -newkey rsa:4096 \
  -out /certs/tls.crt \
  -keyout /certs/tls.key \
  -days 365 \
  -nodes \
  -sha256 \
  -extensions san \
  -config "${THIS_DIR}"/tls.req
