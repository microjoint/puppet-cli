class cli::sudo (
  $group_with_passwd     = $cli::params::group_with_passwd,
  $group_without_passwd  = $cli::params::group_without_passwd,
) inherits cli::params {
  package { 'sudo':
    ensure  => latest,
    require => Group["$group_with_passwd", "$group_without_passwd"],
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
  group { $group_with_passwd:
    ensure => present,
  }
  group { $group_without_passwd:
    ensure => present,
  }
}
