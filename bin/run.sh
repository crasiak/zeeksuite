#!/bin/bash

set -euxo pipefail

cd packer
vagrant box add zeek ./ubuntu-18.04-virtualbox.box --force || true
vagrant up
