require 'spec_helper'

describe 'android::extra', :compile do

  let(:title) { 'extra-google-play_billing' }
  it { should contain_android__package(title).with_type('extra') }

end
