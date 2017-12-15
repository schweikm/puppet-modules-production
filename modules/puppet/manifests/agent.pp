# Class: puppet::agent
# ===========================
#
# Puppet agent configuration
#
# Parameters
# ----------
#
# @param status Whether Puppet runs as a daemon
# * `status`
#    Whether Puppet agent should be running as a daemon
# @param enabled Whether Puppet client should start at boot
# * `enabled`
#    Whether Puppet agent should start at boot
# @param config Hash of configuration options for the [agent] section
# * `config`
#    Hash containing key/value pairs of Puppet configuration directives
#
# Variables
# ----------
#
# Examples
# --------
#
# @example Hiera data for using puppet::agent
#   classes:
#     - puppet::agent
#
#   puppet::agent::status = 'running'
#   puppet::agent::enabled = true
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
class puppet::agent (
  Enum['running', 'stopped']         $status,
  Boolean                            $enabled,
  Hash[String, Hash[String, String]] $config,
) {

  package { 'puppet-agent':
    ensure => installed,
    notify => Service['puppet'],
  }

  # Write each agent configuration option to the puppet.conf file
  keys($config).each|String $section| {
    $config[$section].each |String $setting, String $value| {
      ini_setting { "${section} ${setting}":
        ensure  => present,
        path    => '/etc/puppetlabs/puppet/puppet.conf',
        section => $section,
        setting => $setting,
        value   => $value,
        require => Package['puppet-agent'],
        notify  => Service['puppet'],
      }
    }
  }

  service { 'puppet':
    ensure => $status,
    enable => $enabled,
  }

}
