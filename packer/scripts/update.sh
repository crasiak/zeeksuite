#!/bin/bash -eux

# Disable the release upgrader
sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades

echo "==> Checking version of Ubuntu"
. /etc/lsb-release

if [[ $DISTRIB_RELEASE == 18.04 ]]; then
  echo "==> Disabling periodic apt upgrades"
  echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic
fi

# update just downloads and indexes the list of packages
apt-get -y update

# hook to force upgrade
if [[ $UPDATEF  =~ true || $UPDATEF =~ 1 || $UPDATEF =~ yes ]]; then
    apt-get -y dist-upgrade --force-yes
    reboot
    sleep 60
fi
