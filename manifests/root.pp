class cli::root inherits cli {
  user {'root':
    ensure      => present,
    comment     => 'Root account',
    managehome  => true,
    gid         => root,
    uid         => 0,
    groups      => ['root', 'bin', 'daemon', 'sys', 'adm', 'disk', 'wheel', 'log'],
    home        => '/root',
    shell       => '/bin/bash',
    # password    => template('private/base/root/password'),
    require     => Group['root', 'adm']
  }

  create_resources( group, $groups )

  file {'/root':
    ensure => directory,
    mode   => 0600,
    owner  => 'root',
    group  => 'root',
  }
  file { "/etc/sudoers.d/allow-$group_with_passwd":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0750,
    content => "%$group_with_passwd ALL=(ALL) PASSWD: ALL",
    require => [ Group[$group_with_passwd], Package['sudo'] ]
  }
  file { "/etc/sudoers.d/allow-$group_without_passwd":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0750,
    content => "%$group_without_passwd ALL=(ALL) NOPASSWD: ALL",
    require => [ Group[$group_without_passwd], Package['sudo'] ]
  }
  group { $sudo_grp_with_passwd: ensure => present, }
  group { $sudo_grp_without_passwd: ensure => present, }
}
