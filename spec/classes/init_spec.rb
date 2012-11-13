require 'spec_helper'

describe "android" do

  let(:facts) { {
    :operatingsystem => 'CentOS',
    :kernel => 'Linux',
    :osfamily => 'RedHat'
  } }

  context 'default' do
    version = '20.0.3'
    it { should include_class('android::paths') }
    it { should include_class('android::sdk') }
    it { should include_class('android::platform_tools') }

    it { should contain_Wget__Fetch("download-androidsdk").with({ 
      :source => "http://dl.google.com/android/android-sdk_r#{version}-linux.tgz",
      :destination => "/usr/local/src/android-sdk_r#{version}-linux.tgz"}) 
    }
    it { should contain_exec('update-android-package-platform-tools')
        .with_command('/usr/local/android/android-sdk-linux/tools/android update sdk -u -t platform-tools  ') 
    }

    it { should contain_file('/usr/local/android').with( { :owner => 'root', :group => 'root' }) }
    it { should contain_exec('unpack-androidsdk').with( { :cwd => '/usr/local/android',:user => 'root' } ) }
  end

  context 'non-default version' do
    version = '2.0.0'
    let(:params) { {
      :version => version
    } }
    it { should contain_Wget__Fetch("download-androidsdk").with({ 
      :source => "http://dl.google.com/android/android-sdk_r#{version}-linux.tgz",
      :destination => "/usr/local/src/android-sdk_r#{version}-linux.tgz"}) 
    }

  end

  context 'with proxy' do
    let(:params) { {
      :proxy_host => 'myhost',
      :proxy_port => '1234'
    } }
    it { should contain_exec('update-android-package-platform-tools')
        .with_command('/usr/local/android/android-sdk-linux/tools/android update sdk -u -t platform-tools --proxy-host myhost --proxy-port 1234') }
    end

    context 'with installdir' do
      version = '20.0.3'
      let(:params) { { :installdir => '/myinstalldir' } }
      it { should contain_exec('unpack-androidsdk').with_cwd('/myinstalldir') }
    end

    context 'with different owner' do
      let(:params) { {
        :user => 'myuser',
        :group => 'mygroup'
      } }

      it { should contain_file('/usr/local/android').with( { :owner => 'myuser', :group => 'mygroup' } ) }
    end
end