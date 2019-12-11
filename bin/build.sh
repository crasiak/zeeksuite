#!/bin/bash

set -euxo pipefail

cd packer
packer build ubuntu.json
