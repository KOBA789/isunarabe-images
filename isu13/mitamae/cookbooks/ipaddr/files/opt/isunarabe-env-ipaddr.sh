#!/usr/bin/env bash
set -eux

if test -f /opt/isunarabe-env-ipaddr.sh.lock; then
  exit
fi

touch /opt/isunarabe-env-ipaddr.sh.lock

instance_ip=$(hostname -i)
if [[ -n $instance_ip ]]; then
  sed -Ei 's/^ISUCON13_POWERDNS_SUBDOMAIN_ADDRESS=.+$/ISUCON13_POWERDNS_SUBDOMAIN_ADDRESS="'"${instance_ip}"'"/' /home/isucon/env.sh
fi
chmod 0644 /home/isucon/env.sh
chown isucon:isucon /home/isucon/env.sh
