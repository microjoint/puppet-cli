class cli::nobeep inherits cli::params {
  file {'/etc/modprobe.d/nobeep.conf':
    ensure  => file,
    content => 'blacklist pcspkr',
}
