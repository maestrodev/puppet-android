require 'spec_helper'

describe "android::sdk" do
  let(:pre_condition) { 'include android' }

  context '64bit RedHat', :compile do
    it { should contain_package('glibc.i686') }
    it { should contain_package('zlib.i686') }
    it { should contain_package('libstdc++.i686') }
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

end
