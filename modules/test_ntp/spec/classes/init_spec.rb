require 'spec_helper'

describe 'ntp' do
  it { is_expected.to compile }
  it { is_expected.to compile.with_all_deps }

  it { should contain_class('ntp::install') }
  it { should contain_class('ntp::config') }
  it { should contain_class('ntp::service') }

  describe "ntp::install" do
    let(:params) {{ :package_name => 'ntp', :package_ensure => 'latest', }}

    it { should contain_package('ntp').with(
      :ensure => 'latest'
    )}
  end
end
