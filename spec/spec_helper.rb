require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.before(:each) do
    Puppet::Util::Log.level = :warning
    Puppet::Util::Log.newdestination(:console)
  end

  c.default_facts = {
    :operatingsystem => 'CentOS',
    :kernel => 'Linux',
    :osfamily => 'RedHat',
    :architecture => 'x86_64'
  }
end
