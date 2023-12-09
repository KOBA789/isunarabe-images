#!/bin/bash

set -e -Cue -o pipefail

systemctl start mysql
systemctl start pdns
systemctl start nginx
systemctl start isupipe-go

curl -s --retry 180 --retry-delay 3 --retry-all-errors -k -H 'Host: pipe.t.isucon.pw' -X POST https://127.0.0.1:443/api/initialize
REPORT_FD=1 BENCHWARMER_targets=127.0.0.1 /opt/bench/bench.sh
