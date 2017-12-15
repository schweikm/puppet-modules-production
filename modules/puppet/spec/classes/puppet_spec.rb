require 'spec_helper'

describe 'puppet', :type => 'class' do
  context 'with defaults for all parameters' do
    it do
      should contain_class('puppet')
    end

    it do
      should compile.with_all_deps
    end
  end
end
