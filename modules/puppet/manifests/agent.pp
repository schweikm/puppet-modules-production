class puppet::agent (
  Enum['running', 'stopped'] $status,
  Boolean                    $enabled,
  Hash                       $config = {},
) inherits puppet {

  package { 'puppet-agent':
    ensure => $version,
    notify => Service['puppet'],
  }

  # Write each agent configuration option to the puppet.conf file
  $config.each |String $setting, String $value| {
    ini_setting { 'agent $setting':
      ensure  => present,
      path    => '/etc/puppetlabs/puppet/puppet.conf',
      section => 'agent',
      setting => $setting,
      value   => $value,
      require => File['/etc/puppetlabs/puppet/puppet.conf'],
      notify  => Service['puppet'],
    }
  }

  service { 'puppet':
    ensure    => $status,
    enable    => $enabled,
    subscribe => Package['puppet-agent'],
  }

}
