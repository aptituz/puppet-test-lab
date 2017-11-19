class role::foreman {
  include profile::r10k
  include profile::foreman
  include profile::puppetserver

}