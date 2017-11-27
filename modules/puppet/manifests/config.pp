# puppet config
class puppet::config (
  Boolean $usecacheonfailure,
  String $puppetserver,
  String $certname,
) {

  file { '/etc/puppetlabs/puppet/puppet.conf':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
  }

  ini_setting { 'puppet.conf usecacheonfailure':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'main',
    setting => 'usecacheonfailure',
    value   => $usecacheonfailure,
    require => File['/etc/puppetlabs/puppet/puppet.conf'],
  }

  ini_setting { 'puppet.conf server':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'agent',
    setting => 'server',
    value   => $puppetserver,
    require => File['/etc/puppetlabs/puppet/puppet.conf'],
  }

  ini_setting { 'puppet.conf certname':
    ensure  => present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => 'agent',
    setting => 'certname',
    value   => $certname,
    require => File['/etc/puppetlabs/puppet/puppet.conf'],
  }

}
