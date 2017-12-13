# core
class profiles::core {

  class { '::puppet':
    stage => 'first',
  }

#  include '::ntp'

#  class { '::motd':
#    template => 'core/motd.erb',
#  }

}
