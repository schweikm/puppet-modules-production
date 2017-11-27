# puppet service
class puppet::service {

  service { 'puppet':
    ensure => running,
    enable => true,
  }

}
