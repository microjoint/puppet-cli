class cli::networking {
  package {'dnsutils': ensure   => present } # dig
  package {'net-tools': ensure  => present } # netstat
  package {'gnu-netcat': ensure => present } # nc, netcate
  package {'iputils': ensure    => present } # ping
  package {'traceroute': ensure => present }
  package {'openssh': ensure    => present }
  package {'rsync': ensure      => present }
  package {'nmap': ensure       => present }
  package {'w3m': ensure        => present }
}
