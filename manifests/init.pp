class cli (
  $editor                   = $cli::params::editor,
  $path                     = $cli::params::path,
  $visual                   = $cli::params::visual,
  $umask                    = $cli::params::umask,
  $bash                     = $cli::params::bash,
  $bash_config              = $cli::params::bash_config,
) inherits cli::params {

  validate_string($editor)
  validate_string($path)
  validate_string($visual)
  validate_string($umask)
  validate_bool($bash)
  validate_hash($bash_config) # i may be a hash ???

  include '::cli::install'
  include '::cli::config'

  Class['::cli::install'] -> Class['::cli::config']
}

