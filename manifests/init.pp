class cli (
  $editor                   = $cli::params::editor,
  $path                     = $cli::params::path,
  $visual                   = $cli::params::visual,
  $umask                    = $cli::params::umask,
  $sudo_grp_with_passwd     = $cli::params::group_with_passwd,
  $sudo_grp_without_passwd  = $cli::params::group_without_passwd,
  $bash                     = $cli::params::bash,
  $bash_config              = $cli::params::bash_config,
) inherits cli::params {

  validate_string($editor)
  validate_string($path)
  validate_string($visual)
  validate_string($umask)
  validate_string($sudo_grp_with_passwd)
  validate_string($sudo_grp_without_passwd)
  validate_bool($bash)
  validate_string($bash_config) # i may be a hash ???

  include '::cli::install'
  include '::cli::config'

  Class['::cli::install'] -> Class['::cli::sudo'] -> Class['::cli::config']
}

