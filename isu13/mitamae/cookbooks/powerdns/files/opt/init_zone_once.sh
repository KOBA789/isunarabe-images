#!/usr/bin/env bash
set -eux
cd "$(dirname "$0")"
# PowerDNS の起動後に呼ばれ、ゾーンがない場合に初期化を行います

if test -f /home/isucon/env.sh; then
  source /home/isucon/env.sh
fi

ISUCON_SUBDOMAIN_ADDRESS=${ISUCON13_POWERDNS_SUBDOMAIN_ADDRESS:-127.0.0.1}

if ! (pdnsutil list-all-zones | grep  t.isucon.pw); then
    pdnsutil create-zone t.isucon.pw
    pdnsutil add-record t.isucon.pw "." A 30 "$ISUCON_SUBDOMAIN_ADDRESS"
    pdnsutil add-record t.isucon.pw "pipe" A 30 "$ISUCON_SUBDOMAIN_ADDRESS"
    pdnsutil add-record t.isucon.pw "test001" A 30 "$ISUCON_SUBDOMAIN_ADDRESS"
fi

exit
