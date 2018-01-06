# role Puppet server
class role::puppet_server {
  include '::profile::core'
  include '::profile::puppet_server'
}
