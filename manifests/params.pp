class cli::params {
  $editor                 = 'vim'
  $path                   = '/usr/local/sbin:/usr/local/bin:/usr/bin'
  $visual                 = '/usr/bin/vim'
  $umask                  = "022"
  $bash                   = true
  $bash_config            =
  {
    '/etc/bash.bashrc' =>
    {
      ensure  => file,
      source  => 'puppet:///modules/cli/etc/bash.bashrc',
    },
    '/etc/bash.bash_logout' =>
    {
      ensure  => file,
      source  => 'puppet:///modules/cli/etc/bash.bash_logout',
    }
  }
  $groups        	=
  {
    'root' => { ensure => present },
    'adm' => { ensure => present },
  }
}
