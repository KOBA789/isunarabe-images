#!/bin/bash

set -Cue -o pipefail

cd "${BENCH_DIR:-/opt/bench}"

IFS="," read -r -a targets <<< "${BENCHWARMER_targets}"
nameserver="${targets[0]}"
webapps=("${targets[@]:1}")
args=(--nameserver "$nameserver")
for ip in "${webapps[@]}"; do
  args+=(--webapp "$ip")
done

./bench run --target https://pipe.u.isucon.dev --enable-ssl "${args[@]}" 2>&1
cat /tmp/result.json > "/dev/fd/${REPORT_FD}"
rm -f /tmp/result.json
