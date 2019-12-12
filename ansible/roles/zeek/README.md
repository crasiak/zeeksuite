Zeek
====

The zeek role is responsible for installing Zeek from source. The user can
specify the repository URL and branch. Additional zeek packages can also be installed.

PF_RING is an optional install - AF_PACKET is used if PF_RING is not installed.

Role Variables
--------------

The following variables can be changed to *customize* your Zeek install.

`zeek_base` - The directory you want to install zeek into. It is set to default
to `/opt/zeek`

`zeek_src_repo` - The repository to install zeek from. It defaults to https://github.com/zeek/zeek

`zeek_repo_branch` Use this variable to set the branch to clone. Default 'release/3.0'

`zeek_user` - This role is configured to Zeek with 'zeek'

`zeek_geoip` - Enable GeoIP in Zeek. Default: True

`zeek_geoip_db_url` http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz

`zeek_interface` - The zeek capture network interface. This is the interface
zeek is configured to lisen to. It defaults to `enp0s8`

`zeek_custom_scripts` - install custome zeek scripts here

`zeek_packages`- Install additional packages. Default will install:

    - 'zeek/j-gras/bro-af_packet-plugin'
    - 'zeek/salesforce/ja3'
    - 'zeek/salesforce/hassh'

`zeek_mail_to` - Set the mail-to field in zeek configuration file.

`timezone` - Change the timezone of the VM. Default: US/Pacific

`zeek_pfring` - Enable PF_RING packet capture. If unset, zeek will use AF_PACKET
for packet capture.

`pf_procs` - Number of processes to assign to packet capturing. Default 1

`pf_ring_dir` - Set the install directory of PF_RING. Defualt: /opt/PF_RING

Example Playbook
----------------

```
$ cat playbook.yml
  - hosts: servers
    gather_facts: yes
    name: Setup Zeek in a VM
    roles:
      - {role: 'zeek'}
$ ansible-playbook -vvv playbook.yml
```

#### Next Steps

 Probably stating what's already in Issues.

I want to add the following features and tackle remaining low-hanging fruit from
my original to-do list eg: finish integration and testing pf_ring [#10](https://github.com/crasiak/zeeksuite/issues/9) add 
options like installing zeek from a package [#7](https://github.com/crasiak/zeeksuite/issues/7) or finish setting port mirroring. 

Features and bugs are being tracked in Issues.


### Licensing

This repo and it's contents are free (as in beer) under the Apache-2.0 license.
Please see LICENSE.md for more information

### Sponsored by

Created by Jonathan Stasiak, sponsored by [Corelight](http://corelight.com)

Pull requests welcome.
