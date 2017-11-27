# puppet install
class puppet::install {

  package { 'puppet-agent':
    ensure => installed,
  }

}
