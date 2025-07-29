#!/bin/bash

[ ! -f /data/radicale.conf ] && (mkdir -p /data ; cp /radicale.conf /data)

[ -n "${IMAP_HOST}" ] && sed -i "s/IMAP_HOST/$IMAP_HOST/" /data/radicale.conf

exec "$@"
