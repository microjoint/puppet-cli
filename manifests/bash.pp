class cli::bash (
  $path     = cli::params::path,
  $editor   = cli::params::editor,
  $visual   = cli::params::visual,
  $umask    = cli::params::umask,
) inherits cli::params {
  package { 'bash-completion': ensure => latest }
  package { 'fortune-mod': ensure => latest }
  package { 'ponysay': ensure => latest }

  file { '/etc/bash.bashrc':
    ensure   => 'file',
    source   => 'puppet:///modules/cli/bash.bashrc',
  }
  file { '/etc/bash.bash_logout':
    ensure   => 'file',
    source   => 'puppet:///modules/cli/bash.bash_logout',
  }
}
