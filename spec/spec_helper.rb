require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.before(:each) do
    Puppet::Util::Log.level = :warning
    Puppet::Util::Log.newdestination(:console)
  end
  c.treat_symbols_as_metadata_keys_with_true_values = true

  c.default_facts = {
    :operatingsystem => 'CentOS',
    :kernel => 'Linux',
    :osfamily => 'RedHat',
    :architecture => 'x86_64'
  }

  c.before do
    # avoid "Only root can execute commands as other users"
    Puppet.features.stubs(:root? => true)
  end
end

shared_examples :compile, :compile => true do
  it { should compile.with_all_deps }
end
