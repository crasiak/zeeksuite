## zeeksuite

Get up and running with [Zeek](https://zeek.org)

### TL;DR

Make sure you have [VirtualBox](https://virtualbox.org), [Packer](https://packer.io), [Vagrant](https://vagrantup.com) and [Ansible](https://ansible.com)installed. See
the install section below for more info.

  ```
  curl -fsSL https://git.io/JeHEk | /bin/bash
  ```

`build.sh` can be run again if the build fails:
```
  bin/build.sh
```

`run.sh` attempts to load the box and runs it.
```
  bin/build.sh
```

Login to your new VM
```
  vagrant ssh
```

Work interactively with zeek (as zeek user)
```
  sudo -u zeek -i 
```
NB: -i, --login tells sudo to run as login shell.

Start zeek
```
  $ zeekctl
[ZeekControl] > deploy
stopping workers ...
creating crash report for previously crashed nodes: worker-1-1, worker-1-2, worker-2-1, worker-2-2
stopping proxy ...
creating crash report for previously crashed nodes: proxy-1
stopping manager ...
creating crash report for previously crashed nodes: manager
stopping logger ...
creating crash report for previously crashed nodes: logger
starting ...
starting logger ...
starting manager ...
starting proxy ...
starting workers ...
[ZeekControl] > status
Name         Type    Host             Status    Pid    Started
logger       logger  localhost        running   3186   16 Dec 13:00:04
manager      manager localhost        running   3233   16 Dec 13:00:05
proxy-1      proxy   localhost        running   3279   16 Dec 13:00:07
worker-1-1   worker  localhost        running   3372   16 Dec 13:00:08
worker-1-2   worker  localhost        running   3371   16 Dec 13:00:08
worker-2-1   worker  localhost        running   3373   16 Dec 13:00:08
worker-2-2   worker  localhost        running   3370   16 Dec 13:00:08
[ZeekControl] > exit
```
NB: output from deploying Zeek and starting in cluster mode

### Overview

zeeksuite is a collection of tools to help you get started or maintain an existing
[Zeek](https://zeek.org) install. This repository contains [Packer](https://packer.io) templates configured to
create an Ubuntu64 18.04 image installed with Zeek running on [VirtualBox](https://virtualbox.org).

Zeek is installed from source with [Ansible](https://ansible.com). The virtual machine the script 
produces has been configured in cluster mode. cluster mode is optional. 
Zeek is configured to listen to the 'eth0' which has been made promiscuous mode 
for collection. A mirror port setup is in the works.

The Ansible Zeek role should install on any existing Ubuntu 18.04 virtual
machine.

#### Zeek

Zeek is installed in `/opt/zeek`. It's currently deployed in cluster mode.
It's configured with the AF_PACKET and hassh packages from zkg. 

`zkg` is available to install new packages. Add or remove packages from
`defaults/main.yml` in the zeek role. 

Zeek listens to the interface defined as the Ansible variable `zeek_interface`.
The VM is configured with a mirror port (brigde on a second eth) that has been
set to promiscuous.

The current repository is cloned from the latest stable branch `release/3.0`

#### Packet Capture

Zeeksuite supports both PF_RING and AF_PACKET. AF_PACKET was favored as it was a
quicker install. 

Change `defaults/main.yml` in the zeek ansible role to modify settings.

### Prerequisites

The following tools are needed to build new zeek machines.

#### VirtualBox

VirualBox can be intalled via brew
```
brew cask install virtualbox
```

NB: Mac VirtualBox install:

I had to explicitly allow the installer to complete in System Preferencs >
Security. See the following for [help](https://medium.com/@DMeechan/fixing-the-installation-failed-virtualbox-error-on-mac-high-sierra-7c421362b5b5).


#### Packer

If you're on a Mac you can use [homebrew](https://brew.sh/) to install Packer.
```
brew install packer
```

Or, Packer can be downloaded and installed via the [downloads](https://www.packer.io/downloads.html) page. 

#### Vagrant

If you're on a Mac you can use [homebrew](https://brew.sh/) to install Vagrant.
```
brew cask install vagrant
```

Vagrant binaries can also be downloaded at https://vagrantup.com/downloads

The repo contains Vagrantfile, which has been configured to run the
box file produced by Packer. Run a custom virtual machine by changing the
following line in the Vagrantfile:

```
virtualbox.vm.box = "ubuntu1804-virtualbox.box"
```

#### Ansible

Ansible can be installed with pip.  If you're on a fresh system, pip can be
installed with `easy_install pip` (which assumes you have python installed).
```
pip3 install --user ansible molecule
```

If you already have an Ubuntu 18.04 image you want to use, you can add Zeek
using the included Ansible playbook!

```
cd ansible
ansbile-playbook playbook.yml
```

##### Testing & Molecule

This has been tested on OSX (Mojave v10.14.6) and Arch Linux (kernel v5.4.2).

The zeek role was built and tested with molecule. The configuration has been
updated to use VirualBox. Rudimentary [Testinfra](https://testinfra.readthedocs.io/en/latest/) tests have been included 
but could stand to be expanded.

#### Customizing

See role's [README.md](ansible/roles/zeek/README.md) for a full breakdown of variables currently available

#### Next Steps

Next up: continue to tackle remaining low-hanging fruit: Build images with CI,
add a second nic to add a capture nic. Validate PF_RING and address bugs are 
being tracked in Issues.

#### Licensing

This repo and it's contents are free (as in beer) under the Apache-2.0 license.
Please see LICENSE for more information

### Author

Created by Jonathan Stasiak jw@crasiak.net, sponsored by [Corelight](http://corelight.com)

Pull requests welcome!
