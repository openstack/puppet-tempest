require 'spec_helper'

describe 'tempest' do
  shared_examples 'tempest' do

    let :pre_condition do
      "include ::glance
       class { 'neutron': rabbit_password => 'passw0rd' }"
    end

    context 'without parameters' do
      describe "should raise error" do
        it { expect { is_expected.to contain_class('tempest::params') }.to raise_error(Puppet::Error, /A value for either image_name or image_ref/) }
      end
    end

    context 'with image_name parameters' do
      let :params do
        { :image_name => 'image_name' }
      end

      describe "should raise error" do
        it { expect { is_expected.to contain_class('tempest::params') }.to raise_error(Puppet::Error, /A value for either image_name_alt or image_ref_alt/) }
      end
    end

    context 'with image_ref parameters' do
      let :params do
        { :image_ref        => '4c423fc6-87f7-4e6d-9d3c-abc13058ae5b',
          :image_ref_alt    => '4c423fc6-87f7-4e6d-9d3c-abc13058ae5b' }
      end

      it 'configures image_ref' do
        is_expected.to contain_tempest_config('compute/image_ref').with_value('4c423fc6-87f7-4e6d-9d3c-abc13058ae5b')
      end
    end

    context 'with image_name' do
      let :params do
        { :image_name       => 'cirros',
          :image_name_alt   => 'cirros' }
      end

      it 'uses a resource to configure image_ref from image_name' do
        is_expected.to contain_tempest_glance_id_setter('image_ref').with_image_name('cirros')
      end
    end

    context 'with image_ref and image_name parameters' do
      let :params do
        { :image_name       => 'cirros',
          :image_name_alt   => 'cirros',
          :image_ref        => '4c423fc6-87f7-4e6d-9d3c-abc13058ae5b',
          :image_ref_alt    => '4c423fc6-87f7-4e6d-9d3c-abc13058ae5b' }
      end

      it_raises 'a Puppet::Error', /either image_name or image_ref/
    end

    context 'with public_network_id parameter' do
      let :params do
        { :neutron_available => true,
          :configure_images  => false,
          :public_network_id => '4c423fc6-87f7-4e6d-9d3c-abc13058ae5b' }
      end

      it 'configures public_network_id' do
        is_expected.to contain_tempest_config('network/public_network_id').with_value('4c423fc6-87f7-4e6d-9d3c-abc13058ae5b')
      end
    end

    context 'with public_network_name parameter' do
      let :params do
        { :neutron_available   => true,
          :configure_images    => false,
          :public_network_name => 'public' }
      end

      it 'uses a resource to configure public_network_id from public_network_name' do
        is_expected.to contain_tempest_neutron_net_id_setter('public_network_id').with_network_name('public')
      end
    end

    context 'with public_network_id and public_network_name' do
      let :params do
        { :neutron_available   => true,
          :configure_images    => false,
          :public_network_name => 'public',
          :public_network_id   => '4c423fc6-87f7-4e6d-9d3c-abc13058ae5b' }
      end

      it_raises 'a Puppet::Error', /either public_network_id or public_network_name/
    end

    context 'without configures images and neutron_available' do
      let :params do
        { :configure_images  => false,
          :neutron_available => true }
      end

      describe "should raise error" do
        it { expect { is_expected.to contain_class('tempest::params') }.to raise_error(Puppet::Error, /A value for either public_network_id or public_network_name/) }
      end
    end

    context 'with parameters' do
      let :params do
        { :configure_images    => true,
          :image_name          => 'image name',
          :image_name_alt      => 'image name alt',
          :public_network_name => 'network name',
          :neutron_available   => true,
          :install_from_source => true
        }
      end

      describe "should install tempest" do
        it 'installs packages' do

          is_expected.to contain_package('git')
          is_expected.to contain_package('python-setuptools')

          platform_params[:dev_packages].each do |package|
            is_expected.to contain_package("#{package}")
          end

          is_expected.to contain_class('tempest::params')

          is_expected.to contain_exec('install-pip').with(
            :command => '/usr/bin/easy_install pip',
            :unless  => '/usr/bin/which pip',
            :require => 'Package[python-setuptools]'
          )

          is_expected.to contain_exec('install-tox').with(
            :command => /pip install -U tox$/,
            :unless  => '/usr/bin/which tox',
            :require => 'Exec[install-pip]'
          )

          is_expected.to contain_vcsrepo('/var/lib/tempest').with(
            :ensure   => 'present',
            :source   => 'git://github.com/openstack/tempest.git',
            :revision => nil,
            :provider => 'git',
            :require  => 'Package[git]',
            :user     => 'root'
          )
        end

        it 'configure tempest config' do
          is_expected.to contain_tempest_config('compute/change_password_available').with(:value => nil)
          is_expected.to contain_tempest_config('compute/flavor_ref').with(:value => nil)
          is_expected.to contain_tempest_config('compute/flavor_ref_alt').with(:value => nil)
          is_expected.to contain_tempest_config('compute/image_alt_ssh_user').with(:value => nil)
          is_expected.to contain_tempest_config('compute/image_ref').with(:value => nil)
          is_expected.to contain_tempest_config('compute/image_ref_alt').with(:value => nil)
          is_expected.to contain_tempest_config('compute/image_ssh_user').with(:value => nil)
          is_expected.to contain_tempest_config('compute/resize_available').with(:value => nil)
          is_expected.to contain_tempest_config('compute/allow_tenant_isolation').with(:value => nil)
          is_expected.to contain_tempest_config('identity/admin_password').with(:value => nil)
          is_expected.to contain_tempest_config('identity/admin_domain_name').with(:value => nil)
          is_expected.to contain_tempest_config('identity/admin_password').with_secret( true )
          is_expected.to contain_tempest_config('identity/admin_tenant_name').with(:value => nil)
          is_expected.to contain_tempest_config('identity/admin_username').with(:value => nil)
          is_expected.to contain_tempest_config('identity/admin_role').with(:value => nil)
          is_expected.to contain_tempest_config('identity/auth_version').with(:value => 'v2')
          is_expected.to contain_tempest_config('identity/alt_password').with(:value => nil)
          is_expected.to contain_tempest_config('identity/alt_password').with_secret( true )
          is_expected.to contain_tempest_config('identity/alt_tenant_name').with(:value => nil)
          is_expected.to contain_tempest_config('identity/alt_username').with(:value => nil)
          is_expected.to contain_tempest_config('identity/password').with(:value => nil)
          is_expected.to contain_tempest_config('identity/password').with_secret( true )
          is_expected.to contain_tempest_config('identity/tenant_name').with(:value => nil)
          is_expected.to contain_tempest_config('identity/uri').with(:value => nil)
          is_expected.to contain_tempest_config('identity/uri_v3').with(:value => nil)
          is_expected.to contain_tempest_config('identity/username').with(:value => nil)
          is_expected.to contain_tempest_config('identity-feature-enabled/api_v2').with(:value => true)
          is_expected.to contain_tempest_config('identity-feature-enabled/api_v3').with(:value => true)
          is_expected.to contain_tempest_config('network/public_network_id').with(:value => nil)
          is_expected.to contain_tempest_config('network/public_router_id').with(:value => '')
          is_expected.to contain_tempest_config('dashboard/login_url').with(:value => nil)
          is_expected.to contain_tempest_config('dashboard/dashboard_url').with(:value => nil)
          is_expected.to contain_tempest_config('service_available/cinder').with(:value => true)
          is_expected.to contain_tempest_config('service_available/glance').with(:value => true)
          is_expected.to contain_tempest_config('service_available/heat').with(:value => false)
          is_expected.to contain_tempest_config('service_available/ceilometer').with(:value => false)
          is_expected.to contain_tempest_config('service_available/aodh').with(:value => false)
          is_expected.to contain_tempest_config('service_available/horizon').with(:value => true)
          is_expected.to contain_tempest_config('service_available/neutron').with(:value => true)
          is_expected.to contain_tempest_config('service_available/nova').with(:value => true)
          is_expected.to contain_tempest_config('service_available/sahara').with(:value => false)
          is_expected.to contain_tempest_config('service_available/murano').with(:value => false)
          is_expected.to contain_tempest_config('service_available/swift').with(:value => false)
          is_expected.to contain_tempest_config('service_available/trove').with(:value => false)
          is_expected.to contain_tempest_config('service_available/ironic').with(:value => false)
          is_expected.to contain_tempest_config('whitebox/db_uri').with(:value => nil)
          is_expected.to contain_tempest_config('cli/cli_dir').with(:value => nil)
          is_expected.to contain_tempest_config('oslo_concurrency/lock_path').with(:value => '/var/lib/tempest')
          is_expected.to contain_tempest_config('DEFAULT/debug').with(:value => false)
          is_expected.to contain_tempest_config('DEFAULT/verbose').with(:value => false)
          is_expected.to contain_tempest_config('DEFAULT/use_stderr').with(:value => true)
          is_expected.to contain_tempest_config('DEFAULT/use_syslog').with(:value => false)
          is_expected.to contain_tempest_config('DEFAULT/log_file').with(:value => nil)
          is_expected.to contain_tempest_config('scenario/img_dir').with(:value => '/var/lib/tempest')
          is_expected.to contain_tempest_config('scenario/img_file').with(:value => 'cirros-0.3.4-x86_64-disk.img')
          is_expected.to contain_tempest_config('service_broker/run_service_broker_tests').with(:value => false)
        end

        it 'set glance id' do
          is_expected.to contain_tempest_glance_id_setter('image_ref').with(
            :ensure            => 'present',
            :tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
            :image_name        => 'image name',
          )

          is_expected.to contain_tempest_glance_id_setter('image_ref_alt').with(
            :ensure            => 'present',
            :tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
            :image_name        => 'image name alt',
          )
        end

        it 'neutron net id' do
          is_expected.to contain_tempest_neutron_net_id_setter('public_network_id').with(
            :ensure            => 'present',
            :tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
            :network_name      => 'network name',
          )
        end
      end
    end
  end

  context 'on Debian platforms' do
    let :facts do
      { :osfamily     => 'Debian' }
    end

    let :platform_params do
      { :dev_packages => ['python-dev',
                          'libxslt1-dev',
                          'libxml2-dev',
                          'libssl-dev',
                          'libffi-dev',
                          'patch',
                          'gcc' ] }
    end

    it_behaves_like 'tempest'
  end

  context 'on RedHat platforms' do
    let :facts do
      { :osfamily               => 'RedHat',
        :operatingsystemrelease => '7' }
    end

    let :platform_params do
      { :dev_packages => ['python-devel',
                          'libxslt-devel',
                          'libxml2-devel',
                          'openssl-devel',
                          'libffi-devel',
                          'patch',
                          'gcc' ] }
    end

    it_behaves_like 'tempest'
  end

  context 'unsupported operating system' do
    describe 'tempest class without any parameters on Solaris/Nexenta' do
      let :facts do
        { :osfamily => 'Solaris',
        :operatingsystem => 'Nexenta' }
      end

      it { expect { is_expected.to contain_package('tempest') }.to raise_error(Puppet::Error, /Unsupported osfamily: Solaris operatingsystem: Nexenta/) }
    end
  end
end
