#!/bin/bash

set -euxo pipefail

(vagrant halt || true ) && (vagrant box remove zeek || true)
