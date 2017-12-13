class puppet::agent (
  Enum['running', 'stopped'] $status,
  Boolean                    $enabled,
) inherits puppet {

  package { 'puppet-agent':
    ensure => $version,
    notify => Service['puppet'],
  }

  file { '/etc/puppetlabs/puppet/puppet.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('puppet/puppet.conf.epp', {
      'server'          => $server,
      'common_loglevel' => $common_loglevel,
      'agent_loglevel'  => $agent_loglevel,
      'apply_loglevel'  => $apply_loglevel,
    }),
  }

  service { 'puppet':
    ensure    => $status,
    enable    => $enabled,
    subscribe => Package['puppet-agent'],
  }

}
