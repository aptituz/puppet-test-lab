class profile::puppetserver (
  Boolean $autosign = true,
){
  class { '::puppet':
    server   => true,
    autosign => $autosign
  }
}