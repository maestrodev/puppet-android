require 'spec_helper'

describe 'android::ndk' do

    let(:pre_condition) { 'include android' }

    it { should compile }

end
