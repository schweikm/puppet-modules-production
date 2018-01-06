# Puppet Server
class profile::puppet_server {

  class { '::puppet::server':
    stage => 'first',
  }

}
