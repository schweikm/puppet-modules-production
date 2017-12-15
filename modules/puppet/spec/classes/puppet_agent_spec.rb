require 'spec_helper'

describe 'puppet::agent', :type => 'class' do
  context 'with defaults for all parameters' do
    it do
      should contain_class('puppet::agent')
    end

    it do
      should compile.with_all_deps
    end

    it do
      should contain_package('puppet-agent').with({
        :ensure => 'installed'
      })
    end

    it do
      should contain_service('puppet').with({
        :ensure => 'running',
        :enable => true,
      })
    end
  end
end
