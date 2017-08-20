class ntp::service (
  String                     $service_name   = 'ntpd',
  Enum["stopped", "running"] $service_ensure = 'running',
  Boolean                    $service_enable = true,
) {

  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
  }

}

