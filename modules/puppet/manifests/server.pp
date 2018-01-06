# Class: puppet
# ===========================
#
# Puppet Server configuration
#
# Parameters
# ----------
#
# Variables
# ----------
#
# Examples
# --------
#
# Authors
# -------
#
# Marc Schweikert, BITS
#  - report issues at http://github.com/schweikm/puppet-modules-production/issues
#
# Copyright
# ---------
#
# Copyright &copy; 2017 BITS
# Licensed under the MIT License (the "License");
#  you may not use this module except in compliance with the License.
#  https://opensource.org/licenses/MIT
#
class puppet::server(
  Enum['running', 'stopped']         $status,
  Boolean                            $enabled,
  String                             $jvm_heap,
  Hash[String, Hash[String, String]] $config,
) {

  package { 'puppetserver':
    ensure  => installed,
    require => Package['puppet-agent'],
  }

  # Write each master configuration option
  keys($config).each|String $section| {
    $config[$section].each |String $setting, String $value| {
      ini_setting { "master ${section} ${setting}":
        ensure  => present,
        path    => '/etc/puppetlabs/puppet/puppet.conf',
        section => $section,
        setting => $setting,
        value   => $value,
        require => Package['puppetserver'],
        notify  => Service['puppetserver'],
      }
    }
  }

  # also do XMX ini_subsetting
  ['-Xms', '-Xmx'].each |String $jvm_setting| {
    ini_subsetting { "puppetserver jvm heap ${jvm_setting}":
      ensure            => present,
      path              => '/etc/sysconfig/puppetserver',
      key_val_separator => '=',
      section           => '',
      setting           => 'JVM_ARGS',
      subsetting        => $jvm_setting,
      value             => $jvm_heap,
      require           => Package['puppetserver'],
      notify            => Service['puppetserver'],
    }
  }

#  # Write each puppetserver configuration option
#    $puppetserver_config.each |String $setting, String $value| {
#      hocon_setting { "puppetserver ${setting}":
#        ensure  => present,
#        path    => '/etc/puppetlabs/puppetserver/conf.d/puppetserver.conf',
#        setting => $setting,
#        value   => $value,
#        require => Package['puppetserver'],
#        notify  => Service['puppetserver'],
#      }
#    }
#  }

  service { 'puppetserver':
    ensure => $status,
    enable => $enabled,
  }

}
