class cli::sudo (
  $group_with_passwd     = cli::params::group_with_passwd,
  $group_without_passwd  = cli::params::group_without_passwd,
) inherits cli::params {
  package { 'sudo':
    ensure  => latest,
    require => Group["$group_with_passwd", "$group_without_passwd"],
  }
  file { "/etc/sudoers.d/allow-$group_with_passwd":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0440,
    content => "%$group_with_passwd ALL=(ALL) PASSWD: ALL",
  }
  file { "/etc/sudoers.d/allow-$group_without_passwd":
    ensure  => present,
    owner   => root,
    group   => root,
    mode    => 0440,
    content => "%$group_without_passwd ALL=(ALL) NOPASSWD: ALL",
  }
  group { $group_with_passwd:
    ensure => present,
  }
  group { $group_without_passwd:
    ensure => present,
  }
  file {
    '/etc/sudoers.d/defaults_keep_home':
      ensure  => file,
      content => 'Defaults env_kep += "HOME"\n', # Line at the end is important, otherwise sudo will die completely
      require => Package['sudo'],
      mode    => 0440 # Important, otherwise sudo will die completely
  }
}
