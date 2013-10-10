require 'spec_helper'

describe 'android::addon' do

  let(:facts) { {
    :operatingsystem => 'CentOS',
    :kernel => 'Linux',
    :osfamily => 'RedHat'
  } }

  let(:title) { 'android-15' }
  it { should contain_android__package(title).with_type('addon') }

end
