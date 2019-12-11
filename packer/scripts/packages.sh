
apt -y update && apt-get -y upgrade
apt -y install software-properties-common
apt-add-repository ppa:ansible/ansible

# Install Ansible.
apt -y update
DEBIAN_FRONTEND=noninteractive apt -y install ansible dialog apt-utils build-essential curl vim htop nmon slurm tcpdump unzip ntp nfs-common

