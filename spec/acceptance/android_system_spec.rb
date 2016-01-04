require 'spec_helper_acceptance'

describe 'android' do

  let(:manifest) {
    %Q{
      if $::osfamily == 'RedHat' {
        class { 'epel':
          before => Class['android'],
        }
      }
      class { 'java': } ->
      class { 'android': }
    }
  }

  it 'android SDK should install' do
    # Run it twice and test for idempotency.
    apply_manifest(manifest, :catch_failures => true)
    apply_manifest(manifest, :catch_changes => true)
  end

end
