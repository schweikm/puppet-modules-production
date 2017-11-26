class test_ntp::install (
  String                                $package_name   = 'ntp',
  Enum["installed", "latest", "absent"] $package_ensure = 'latest',
) {

  package { $package_name:
    ensure => $package_ensure,
  }
}
