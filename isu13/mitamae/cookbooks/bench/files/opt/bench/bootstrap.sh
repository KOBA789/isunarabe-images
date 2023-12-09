#!/bin/bash

set -Cue -o pipefail

TEAM_TOKEN=$(curl --retry 5 --retry-connrefused --max-time 10 --connect-timeout 5 -H "Authorization: Bearer ${SETUP_TOKEN}" "https://api.isunarabe.org/api/setup/bootstrap")
cat <<EOF > /opt/bench/env
RUST_LOG=info
TEAM_TOKEN=${TEAM_TOKEN}
EOF
chown isucon:isucon /opt/bench/env

systemctl daemon-reload
systemctl enable --now benchwarmer
