class ntp::config (
  Array                $servers = ['0.north-america.pool.ntp.org', '1.north-america.pool.ntp.org'],
  Stdlib::Absolutepath $config  = '/etc/ntp.conf',
) {

  file { $config:
    ensure  => 'file', 
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('ntp/ntp.conf.epp', {'servers' => $servers}),
  }

}

