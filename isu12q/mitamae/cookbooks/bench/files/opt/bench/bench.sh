#!/bin/bash

set -Cue -o pipefail

cd "${BENCH_DIR:-/opt/bench}"

BENCH_TARGET_IP="${BENCHWARMER_target_ip:-192.168.0.11}"
./bench -target-url https://t.isucon.pw -target-addr "${BENCH_TARGET_IP}:443"
