class cli:install inherits cli {
  package { 'bash': ensure => present }
  package { 'bash-completion': ensure => present }
}
