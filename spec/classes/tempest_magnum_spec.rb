require 'spec_helper'

describe 'tempest::magnum' do
  let :params do
    { :nic_id => 'b2e6021a-4956-4a1f-8329-790b9add05a9', }
  end

  shared_examples 'tempest magnum' do
    context 'with default parameters' do
      it 'provisions resources and configures tempest for magnum' do
        is_expected.to contain_glance_image('fedora-atomic-latest').with(
            :ensure     => 'present',
            :source     => 'https://fedorapeople.org/groups/magnum/fedora-atomic-latest.qcow2',
            :properties => '{"os_distro"=>"fedora-atomic"}'
        )
        is_expected.to contain_nova_flavor('s1.magnum').with_ensure('present')
        is_expected.to contain_nova_flavor('m1.magnum').with_ensure('present')

        is_expected.to contain_tempest_config('magnum/image_id').with_value('fedora-atomic-latest')
        is_expected.to contain_tempest_config('magnum/nic_id').with_value('b2e6021a-4956-4a1f-8329-790b9add05a9')
        is_expected.to contain_tempest_config('magnum/keypair_id').with_value('default')
        is_expected.to contain_tempest_config('magnum/flavor_id').with_value('s1.magnum')
        is_expected.to contain_tempest_config('magnum/master_flavor_id').with_value('m1.magnum')
        is_expected.to contain_tempest_config('magnum/copy_logs').with_value('true')
        is_expected.to contain_tempest_config('magnum/dns_nameserver').with_value('8.8.8.8')
      end
    end

    context 'when overriding parameters' do
      before do
        params.merge!({
          :provision_image   => false,
          :image_name        => 'coreos',
          :provision_flavors => 'false',
          :flavor_id         => 's1.tempest',
          :master_flavor_id  => 'm1.tempest',
          :keypair_id        => 'magnum',
          :provision_keypair => false,
          :magnum_url        => 'http://magnum/',
          :copy_logs         => false,
          :dns_nameserver    => '7.7.7.7'
        })
      end

      it 'configures tempest for magnum' do
        is_expected.to contain_tempest_config('magnum/image_id').with_value('coreos')
        is_expected.to contain_tempest_config('magnum/nic_id').with_value('b2e6021a-4956-4a1f-8329-790b9add05a9')
        is_expected.to contain_tempest_config('magnum/keypair_id').with_value('magnum')
        is_expected.to contain_tempest_config('magnum/flavor_id').with_value('s1.tempest')
        is_expected.to contain_tempest_config('magnum/master_flavor_id').with_value('m1.tempest')
        is_expected.to contain_tempest_config('magnum/magnum_url').with_value('http://magnum/')
        is_expected.to contain_tempest_config('magnum/copy_logs').with_value('false')
        is_expected.to contain_tempest_config('magnum/dns_nameserver').with_value('7.7.7.7')
      end
    end
  end

  shared_examples 'installs test packages' do
    describe 'with default parameters installing' do
      it { is_expected.to contain_package('python-magnum-tests').with_ensure('present') }
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end
      it_configures 'tempest magnum'

      case facts[:os]['family']
      when 'RedHat'
        it_configures 'installs test packages'
      end
    end
  end
end
