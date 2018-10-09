import os
import pytest
import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')

# Good example: https://github.com/nephelaiio/ansible-role-rbenv/blob/4771cdc2ee559b78d29929ab0700e8fca15019ab/molecule/compile/tests/test_compile.py


# def test_etc_docker_folders(host):
#     f = host.file('/etc/docker.conf')

#     assert f.exists
#     assert f.user == 'docker'
#     assert f.group == 'nogroup'

#     f = host.file('/etc/docker.hosts')
#     assert f.exists
#     assert f.user == 'docker'
#     assert f.group == 'nogroup'
#     assert f.contains('192.168.33.100 docker1.darklabs.home docker1')
#     assert f.contains('192.168.33.101 docker2.darklabs.home docker2')


# def test_hosts_file(host):
#     f = host.file('/etc/hosts.molecule')

#     assert f.exists
#     assert f.user == 'root'
#     assert f.group == 'root'


@pytest.mark.parametrize('f',
                         ['docker-ce', 'ca-certificates'])
def test_packages_installed(host, f):
    pkg = host.package(f)
    assert pkg.is_installed


def test_docker_running_and_enabled(host):
    docker = host.service("docker")
    assert docker.is_running
    assert docker.is_enabled
    # docker_socket = host.socket("udp://127.0.0.1:53")
    # assert docker_socket.is_listening
    docker_socket = host.socket("tcp://0.0.0.0:2375")
    assert docker_socket.is_listening


def test_docker_group(host):
    docker = host.group("docker")
    assert docker.name == "docker"
    # assert docker.uid == "107"
    # assert docker.gid == 65534
    # assert "docker" in docker.groups
    # assert docker.home == "/var/lib/misc"
    # assert docker.shell == "/bin/false"


def test_user(host):
    user = host.user("test")
    assert user.name == "test"
    # assert docker.uid == "107"
    # assert docker.gid == 65534
    assert "docker" in user.groups
    # assert docker.home == "/var/lib/misc"
    # assert docker.shell == "/bin/false"
