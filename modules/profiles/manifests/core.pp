# core
class profiles::core {

  include '::ntp'

  class { '::motd':
    template => 'core/motd.erb',
  }

}
