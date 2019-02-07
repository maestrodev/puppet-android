require 'spec_helper'

describe "android::sdk" do
  let(:pre_condition) { 'include android' }

  context '64bit RedHat', :compile do
    it { should contain_package('glibc.i686') }
    it { should contain_package('zlib.i686') }
    it { should contain_package('libstdc++.i686') }
    it { should contain_file('android-executable').with({
      'path' => '/usr/local/android/android-sdk-linux/tools/android',
      'mode' => '0755',
      }).that_requires('Exec[unpack-androidsdk]')
    }
  end

  context '64bit RedHat, custom installdir', :compile do
    let(:pre_condition) { 'class { "android": installdir => "/opt/android" }' }

    it { should contain_file('android-executable').with({
      'path' => '/opt/android/android-sdk-linux/tools/android',
      'mode' => '0755',
      }).that_requires('Exec[unpack-androidsdk]')
    }
  end

  context '64bit Debian, x86_64 architecture', :compile do
    let(:facts) { {
      :operatingsystem => 'Ubuntu',
      :osfamily => 'Debian'
    } }
    it { should contain_package('ia32-libs') }
  end

  context '64bit Debian, amd64 architecture', :compile do
    let(:facts) { {
        :operatingsystem => 'Ubuntu',
        :osfamily => 'Debian',
        :architecture => 'amd64'
    } }
    it { should contain_package('ia32-libs') }
  end

  context '64bit Debian Jessie, x86_64 architecture', :compile do
    let(:facts) { {
      :operatingsystem => 'Debian',
      :osfamily => 'Debian'
      :lsbdistcodename => 'jessie'
    } }
    it { should_not contain_package('ia32-libs') }
  end

  context '64bit Debian Jessie, amd64 architecture', :compile do
    let(:facts) { {
        :operatingsystem => 'Debian',
        :osfamily => 'Debian',
        :lsbdistcodename => 'jessie'
        :architecture => 'amd64'
    } }
    it { should_not contain_package('ia32-libs') }
  end

  context '64bit Ubuntu 14.04, x86_64 architecture', :compile do
    let(:facts) { {
      :operatingsystem => 'Ubuntu',
      :osfamily => 'Debian'
      :lsbdistrelease => '14.04'
    } }
    it { should_not contain_package('ia32-libs') }
  end

  context '64bit Ubuntu 14.04, amd64 architecture', :compile do
    let(:facts) { {
        :operatingsystem => 'Ubuntu',
        :osfamily => 'Debian',
        :lsbdistrelease => '14.04'
        :architecture => 'amd64'
    } }
    it { should_not contain_package('ia32-libs') }
  end

end
