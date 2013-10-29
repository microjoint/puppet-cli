class cli (
  $editor                   = $cli::params::editor,
  $path                     = $cli::params::path,
  $visual                   = $cli::params::visual,
  $umask                    = $cli::params::umask,
  $sudo_grp_with_passwd     = $cli::params::group_with_passwd,
  $sudo_grp_without_passwd  = $cli::params::group_without_passwd,
  $bash                     = $cli::params::path,
  $bash_config              = $cli::params::bash_config,
) inherits cli::params {

    include '::cli::install'
    include '::cli::config'

    Class['::cli::install'] -> Class['::cli::root_sudo'] -> Class['::cli::config']
}

