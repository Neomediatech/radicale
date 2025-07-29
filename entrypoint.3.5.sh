#!/bin/bash

RADICALE_OPTIONS=""

[ -n "${IMAP_HOST}" ] && RADICALE_OPTIONS="$RADICALE_OPTIONS --auth-type imap --auth-imap_host=${IMAP_HOST}"
[ -n "${IMAP_SECURITY}" ] && RADICALE_OPTIONS="$RADICALE_OPTIONS --auth-imap_security=${IMAP_SECURITY}"

exec "$@" $RADICALE_OPTIONS

