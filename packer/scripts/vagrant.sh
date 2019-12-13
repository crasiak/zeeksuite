#!/bin/bash

date > /etc/vagrant_box_build_time

SSH_USER=${SSH_USERNAME:-vagrant}
SSH_PASS=${SSH_PASSWORD:-vagrant}
SSH_USER_HOME=${SSH_USER_HOME:-/home/vagrant}
# private key in zeeksuite/packer
VAGRANT_INSECURE_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCrtkqkEKKOBT2jHAvFhGf5T2RVF7JZNGKb5zNr3X+i4RNP9KzRRRJsmfWe/NkXwQfm7qfjRueZyTh5NBDGvhCrNNpQngBxe7oanHVCWirCgsMtfm3ltGxtMChd0iecOdGj9FSUWUBW21meF35goBLMxvHdXZOBlKTd/PKFpScvsiIdX5d8w8z0Hmze9cGjTqB7hzkpC4NfuwXM9zekapcVJM9ieergxzu1qp8ydEloI4PR8U4b+rO4lOzVKZUU9+FqEHM60ig0LXg4kNPpxJJ3atiMbnsSmDIbdZIMhc/3aYybQSOE48HkqcnxWJpXI1jOtlNAqQHjMCCygUYrWzIqytA6xiJIoUTjpash57pvZyMAlZKo6QXOWh0sBO9/TgCJ7zHQW8BpjHVyc+3ve2kOchnXohv6C/15k0QcuKwrFs8i0MZ0ReXQzDkcUK/lfCEesBCrs+VnbO2cIZzfmepRDF23RqmQlSPzc9N7fYN4IZcTkhfjtS03h3U104rMZPBuV8AtHcPCXHqlDTR65U91MT9boBd3nltHe3raECMg68Cv7v9hnoP9CExMI+k5I/C17My3GbWoPeIDym5kYx2OXN3R0xVYoY4dVDPF0VvptX1/T19f5r7hJAR+2TmUaDVcJ3NUVSAT13QCXDf0XWRbZHmP8i8AaT96B0MHbeEPkQ=="


# Packer passes boolean user variables through as '1', but this might change in
# the future, so also check for 'true'.
if [ "$INSTALL_VAGRANT_KEY" = "true" ] || [ "$INSTALL_VAGRANT_KEY" = "1" ]; then
    # Create Vagrant user (if not already present)
    if ! id -u $SSH_USER >/dev/null 2>&1; then
        echo "==> Creating $SSH_USER user"
        /usr/sbin/groupadd $SSH_USER
        /usr/sbin/useradd $SSH_USER -g $SSH_USER -G sudo -d $SSH_USER_HOME --create-home
        echo "${SSH_USER}:${SSH_PASS}" | chpasswd
    fi

    # Set up sudo
    echo "==> Giving ${SSH_USER} sudo powers"
    echo "${SSH_USER}        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
    chmod 440 /etc/sudoers.d/vagrant

    # Fix stdin not being a tty
    if grep -q -E "^mesg n$" /root/.profile && sed -i "s/^mesg n$/tty -s \\&\\& mesg n/g" /root/.profile; then
      echo "==> Fixed stdin not being a tty."
    fi

    echo "==> Installing vagrant key"
    mkdir $SSH_USER_HOME/.ssh
    chmod 700 $SSH_USER_HOME/.ssh
    cd $SSH_USER_HOME/.ssh

    echo "${VAGRANT_INSECURE_KEY}" > $SSH_USER_HOME/.ssh/authorized_keys
    chmod 600 $SSH_USER_HOME/.ssh/authorized_keys
    chown -R $SSH_USER:$SSH_USER $SSH_USER_HOME/.ssh
fi
