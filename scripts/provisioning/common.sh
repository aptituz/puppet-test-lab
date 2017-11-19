PUPPET_PACKAGE=puppetlabs-release-pc1-xenial.deb
PUPPET_PACKAGE_PATH=/vagrant/tmp/${PUPPET_PACKAGE}

prepare() {
    apt-get update
    apt-get -y install ca-certificates

    setup_ssh_keys
    install_puppet
}

setup_ssh_keys() {
    test -f /vagrant/tmp/id_rsa || ssh-keygen -f /vagrant/tmp/id_rsa
}

install_puppet() {
    apt-get -y install ca-certificates

    mkdir -p /vagrant/tmp
    test -f ${PUPPET_PACKAGE_PATH} || wget -O ${PUPPET_PACKAGE_PATH} http://apt.puppetlabs.com/${PUPPET_PACKAGE}
    dpkg -i ${PUPPET_PACKAGE_PATH} &&  apt-get update
    apt-get -y install puppet-agent
}
