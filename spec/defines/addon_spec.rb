require 'spec_helper'

describe 'android::addon' do

  let(:title) { 'android-15' }
  it { should contain_android__package(title).with_type('addon') }

end
