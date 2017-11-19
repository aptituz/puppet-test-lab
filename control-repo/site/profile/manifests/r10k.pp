class profile::r10k {
  class {'r10k::webhook::config':
    use_mcollective => false,
    enable_ssl      => false,
    protected       => false
  }

  class {'r10k::webhook':
    use_mcollective => false,
    user            => 'root',
    group           => '0',
    require         => Class['r10k::webhook::config'],
  }

  class { '::r10k':
    remote => '/srv/repositories/control-repo.git'
  }

  file { '/srv/repositories/control-repo.git/hooks/post-receive':
    ensure  => present,
    mode    => '0755',
    source  => 'puppet:///modules/profile/post-receive'
  }
}