#!/bin/bash

set -e -Cue -o pipefail

cd /root
tar zxvf /dev/shm/build/mitamae.tar.gz
cd ./mitamae
./mitamae local roles/default.rb
