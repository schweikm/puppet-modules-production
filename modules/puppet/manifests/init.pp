# Class: puppet
# ===========================
#
# Full description of class puppet here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'puppet':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class puppet (
  Hash $main_config = {},
  Hash $user_config = {},
) {

  file { '/etc/puppetlabs/puppet/puppet.conf':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['puppet-agent'],
    notify  => Service['puppet'],
  }

  # Write each main configuration option to the puppet.conf file
  $main_config.each |String $setting, String $value| {
    ini_setting { 'main $setting':
      ensure  => present,
      path    => '/etc/puppetlabs/puppet/puppet.conf',
      section => 'main',
      setting => $setting,
      value   => $value,
      require => File['/etc/puppetlabs/puppet/puppet.conf'],
      notify  => Service['puppet'],
    }   
  }

  # Write each user configuration option to the puppet.conf file
  $user_config.each |String $setting, String $value| {
    ini_setting { 'user $setting':
      ensure  => present,
      path    => '/etc/puppetlabs/puppet/puppet.conf',
      section => 'user',
      setting => $setting,
      value   => $value,
      require => File['/etc/puppetlabs/puppet/puppet.conf'],
      notify  => Service['puppet'],
    }   
  }

  include '::puppet::agent'

}
