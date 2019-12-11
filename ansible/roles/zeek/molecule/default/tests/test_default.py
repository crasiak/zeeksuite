import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']
).get_hosts('all')


def test_hosts_file(host):
    f = host.file('/etc/hosts')

    assert f.exists
    assert f.user == 'root'
    assert f.group == 'root'


def test_zeek_user(host):
    u = host.user("zeek")

    assert u.exists


def test_zeek_exists(host):
    f = host.file('/opt/zeek/bin/zeekctl')

    assert f.exists
    assert f.user == 'zeek'
    assert f.group == 'zeek'


def test_zeek_runs(host):

    with host.sudo(user='zeek'):
        cmd = host.run(
                '/opt/zeek/bin/zeek -e "print lookup_location(8.8.8.8);"')
    assert cmd.stderr == ''
    assert not cmd.failed
