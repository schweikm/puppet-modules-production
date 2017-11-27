# puppet
class puppet {

  contain '::puppet::install'
  contain '::puppet::config'
  contain '::puppet::service'

  Class['::puppet::install'] ->
  Class['::puppet::config'] ~>
  Class['::puppet::service']

}
