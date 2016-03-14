require 'spec_helper'

describe 'android::package' do

  let(:dir) { '/usr/local/android' }

  context 'linux', :compile do
    let(:title) { 'android-15' }
    let(:params) { { :type => 'platform' } }
    it { should contain_file("#{dir}/expect-install-android-15")
      .with_content(/android update sdk -u -a -t android-15/) }
    it { should contain_exec('update-android-package-android-15').with({
      :command => "#{dir}/expect-install-android-15",
      :creates => "#{dir}/android-sdk-linux/platforms/android-15",
    }) }
  end
  
  context 'bad package type' do
    let(:title) { 'bad' }
    let(:params) { { :type => 'bad' } }
    
    it do
      expect {
        should raise_error(Puppet::Error, /Unsupported package type: bad/)
      }
    end
  end
  
  context 'Mac OS X', :compile do
    let(:facts) { {
      :kernel => 'Darwin',
    } }
    let(:title) { 'android-15' }
    let(:params) { { :type => 'platform' } }
    it { should contain_file("#{dir}/expect-install-android-15").with_content(/android update sdk -u -a -t android-15/) }
    it { should contain_exec('update-android-package-android-15').with({
      :command => "#{dir}/expect-install-android-15",
      :creates => "#{dir}/android-sdk-macosx/platforms/android-15",
    }) }
  end

end
