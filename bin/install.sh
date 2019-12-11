#!/bin/bash

set -euxo pipefail

git clone https://github.com/crasiak/zeeksuite.git

cd zeeksuite

./bin/build.sh

./bin/run.sh
