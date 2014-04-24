class cli::params {
  $editor                 = 'vim'
  $path                   = '/usr/local/sbin:/usr/local/bin:/usr/bin'
  $visual                 = '/usr/bin/vim'
  $umask                  = "022"
  $group_with_passwd      = 'wheel'
  $group_without_passwd   = 'super_admins'
  $bash                   = true
  $bash_config            =
  {
    '/etc/bash.bashrc' =>
    {
      ensure  => file,
      source  => 'etc/bash.bashrc.erb',
    },
    '/etc/bash.bash_logout' =>
    {
      ensure                => file,
      source                => 'puppet:///modules/etc/bash.bash_logout',
    }
  }
}
