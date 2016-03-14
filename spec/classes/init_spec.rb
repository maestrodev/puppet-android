require 'spec_helper'

describe 'android' do
  let(:version) { '22.3' }
  let(:dir) { '/usr/local/android' }
  let(:facts) { {
    :id => 'root',
  } }

  context 'default', :compile do
    it { should contain_class('android::paths') }
    it { should contain_class('android::sdk') }
    it { should contain_class('android::platform_tools') }

    it { should contain_Wget__Fetch('download-androidsdk').with({
      :source => "http://dl.google.com/android/android-sdk_r#{version}-linux.tgz",
      :destination => "#{dir}/android-sdk_r#{version}-linux.tgz"})
    }

    it { should contain_file("#{dir}/expect-install-platform-tools")
      .with_content(/android update sdk -u -a -t platform-tools/) }
    it { should contain_exec('update-android-package-platform-tools')
      .with_command("#{dir}/expect-install-platform-tools") }

    it { should contain_file(dir).with( { :owner => 'root', :group => 'root' }) }
    it { should contain_exec('unpack-androidsdk').with( { :cwd => dir, :user => 'root' } ) }
  end

  context 'non-default version', :compile do
    let(:version) { '2.0.0' }
    let(:params) { {
      :version => version
    } }
    it { should contain_Wget__Fetch('download-androidsdk').with({
      :source => "http://dl.google.com/android/android-sdk_r#{version}-linux.tgz",
      :destination => "#{dir}/android-sdk_r#{version}-linux.tgz"})
    }

  end

  context 'with proxy', :compile do
    let(:params) { {
      :proxy_host => 'myhost',
      :proxy_port => '1234'
    } }

    it { should contain_file("#{dir}/expect-install-platform-tools")
      .with_content(/android update sdk -u -a -t platform-tools --proxy-host myhost --proxy-port 1234/) }
    it { should contain_exec('update-android-package-platform-tools')
      .with_command("#{dir}/expect-install-platform-tools") }
  end

  context 'with installdir', :compile do
    let(:params) { { :installdir => '/myinstalldir' } }
    it { should contain_file('/myinstalldir') }
    it { should contain_exec('unpack-androidsdk').with_cwd('/myinstalldir') }
  end

  context 'with different owner', :compile do
    let(:params) { {
      :user => 'myuser',
      :group => 'mygroup'
    } }
    let(:facts) { {
      :id => 'root',
    } }
    it { should contain_exec('unpack-androidsdk').with_user('myuser') }
    it { should contain_exec('update-android-package-platform-tools').with_user('myuser') }
    it { should contain_file(dir).with( { :owner => 'myuser', :group => 'mygroup' } ) }
  end

  context 'as non-root user', :compile do
    let(:params) { {
      :user => 'myuser',
      :group => 'mygroup'
    } }
    let(:facts) { {
      :id => 'myuser',
    } }
    it { should contain_exec('unpack-androidsdk').without_user }
    it { should contain_exec('update-android-package-platform-tools').without_user }
    it { should contain_file(dir).with( { :owner => 'myuser', :group => 'mygroup' } ) }
  end

  context 'Mac OS X', :compile do
   let(:facts) { {
        :kernel => 'Darwin',
        :id => 'root',
    } }
    let(:params) { {
      :proxy_host => 'myhost',
      :proxy_port => '1234'
    } }

    it { should contain_Wget__Fetch('download-androidsdk').with({
      :source => "http://dl.google.com/android/android-sdk_r#{version}-macosx.zip",
      :destination => "#{dir}/android-sdk_r#{version}-macosx.zip"})
    }

    it { should contain_file("#{dir}/expect-install-platform-tools")
      .with_content(/android update sdk -u -a -t platform-tools --proxy-host myhost --proxy-port 1234/) }
    it { should contain_exec('update-android-package-platform-tools')
      .with_command("#{dir}/expect-install-platform-tools") }

    it { should contain_file(dir).with( { :owner => 'root', :group => 'admin' }) }
    it { should contain_exec('unpack-androidsdk').with( { :cwd => dir,:user => 'root' } ) }
  end
end
