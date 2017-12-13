# core
class profiles::core {

  class { '::puppet::agent':
    stage => 'first',
  }

#  include '::ntp'

#  class { '::motd':
#    template => 'core/motd.erb',
#  }

}
