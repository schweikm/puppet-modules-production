class motd::install inherits motd {

  package { 'setup':
    ensure => 'latest',
  }

}
