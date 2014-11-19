require 'puppet'
require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

RSpec.configure do |c|

  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.before(:each) do
    Puppet::Util::Log.level = :warning
    Puppet::Util::Log.newdestination(:console)
  end

  c.before :suite do
    hosts.each do |host|
      # Install module and dependencies
      puppet_module_install(:source => proj_root, :module_name => 'android')

      if fact('osfamily') == 'RedHat'
        on host, puppet('module', 'install', 'stahnma/epel', '--version=0.1.0'), { :acceptable_exit_codes => [0,1] }
      end
      on host, puppet('module', 'install', 'puppetlabs/stdlib', '--version=3.2.0'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'puppetlabs/java', '--version=1.2.0'), { :acceptable_exit_codes => [0,1] }
      on host, puppet('module', 'install', 'maestrodev/wget', '--version=1.0.0'), { :acceptable_exit_codes => [0,1] }
    end
  end

end
