class cli::systemd inherits cli::params {
  package {'systemd': ensure => latest }
  group {'adm':
    require => Package['systemd']
  }
  #systemd_service {'systemd-readahead-collect':}
  #systemd_service {'systemd-readahead-replay':}
}
