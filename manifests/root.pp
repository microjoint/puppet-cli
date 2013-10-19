class cli::root inherits cli::params {
  user {'root':
    ensure  => present,
    comment => 'Root account',
    gid     => 0,
    uid     => 0,
    groups  => ['root', 'bin', 'daemon', 'sys', 'adm', 'disk', 'wheel', 'log'],
    home    => '/root',
    shell   => '/bin/bash',
  }

  file {'/root':
    ensure => directory,
    mode   => 0600,
    owner  => 'root',
    group  => 'root',
  }
}
