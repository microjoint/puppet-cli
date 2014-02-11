class cli::config inherits cli {
  $file_defaults = {
    owner => root,
    group => root,
    mode  => '0644',
  }
  if $bash == true {
    create_resources(file, $bash_config, $file_defaults)
  }
  # no PC beep
  file {'/etc/modprobe.d/nobeep.conf':
    ensure  => file,
    content => 'blacklist pcspkr',
}
