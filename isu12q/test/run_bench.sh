#!/bin/bash

set -e -Cue -o pipefail

systemctl start docker
systemctl start mysql
systemctl start nginx
systemctl start blackauth
systemctl start isuports

curl --retry 180 --retry-delay 1 --retry-all-errors -k -H 'Host: admin.t.isucon.pw' -X POST https://127.0.0.1:443/initialize
BENCHWARMER_target_ip=127.0.0.1 /opt/bench/bench.sh
