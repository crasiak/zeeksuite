#!/bin/bash

set -euxo pipefail

cd packer
vagrant box add zeek ./ubuntu1804-virtualbox.box --force || true
vagrant up
