class motd::config inherits motd {

  if $manage_issue {
    $managed_files = [ $motd_file, '/etc/issue' ]
  } else {
    $managed_files = [ $motd_file ]
  }

  file { $managed_files:
    ensure => 'file',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    content => "Resistence is futile.  You will be assimilated\n",
  }

}
