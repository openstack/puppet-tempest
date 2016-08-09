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

    context 'with sahara_plugins' do
      let :params do
        { :configure_images => false,
          :sahara_available => true,
          :sahara_plugins   => ['vanilla'] }
      end

      it 'properly configures Sahara plugins in tempest.conf' do
        is_expected.to contain_tempest_config('data-processing-feature-enabled/plugins').with_value(['vanilla'])
      end
    end

    context 'with tempest_roles' do
      let :params do
        { :configure_images => false,
          :tempest_roles    => ['Member', 'creator'], }
      end

      it 'properly sets  tempest_roles in tempest.conf' do
        is_expected.to contain_tempest_config('auth/tempest_roles').with_value('Member,creator')
      end
    end

    context 'with parameters' do
      let :params do
        { :configure_images    => true,
          :image_name          => 'image name',
          :image_name_alt      => 'image name alt',
          :public_network_name => 'network name',
          :neutron_available   => true,
          :install_from_source => true,
          :setup_venv          => true
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
            :command => 'easy_install pip',
            :unless  => 'which pip',
            :path    => ['/bin', '/usr/bin', '/usr/local/bin'],
            :require => 'Package[python-setuptools]'
          )

          is_expected.to contain_exec('install-tox').with(
            :command => 'pip install -U tox',
            :unless  => 'which tox',
            :path    => ['/bin', '/usr/bin', '/usr/local/bin'],
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

        it 'installs python-openstackclient package' do
          is_expected.to contain_package('python-openstackclient').with(
            :tag => 'openstack'
          )
        end

        it 'configure tempest config' do
          is_expected.to contain_tempest_config('auth/admin_domain_name').with(:value => nil)
          is_expected.to contain_tempest_config('auth/admin_password').with_secret( true )
          is_expected.to contain_tempest_config('auth/admin_project_name').with(:value => nil)
          is_expected.to contain_tempest_config('auth/admin_username').with(:value => nil)
          is_expected.to contain_tempest_config('auth/tempest_roles').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('auth/use_dynamic_credentials').with(:value => nil)
          is_expected.to contain_tempest_config('dns/nameservers').with(:value => nil)
          is_expected.to contain_tempest_config('compute/change_password_available').with(:value => nil)
          is_expected.to contain_tempest_config('compute/flavor_ref').with(:value => nil)
          is_expected.to contain_tempest_config('compute/flavor_ref_alt').with(:value => nil)
          is_expected.to contain_tempest_config('compute/image_alt_ssh_user').with(:value => nil)
          is_expected.to contain_tempest_config('compute/image_ref').with(:value => nil)
          is_expected.to contain_tempest_config('compute/image_ref_alt').with(:value => nil)
          is_expected.to contain_tempest_config('compute/image_ssh_user').with(:value => nil)
          is_expected.to contain_tempest_config('compute/resize_available').with(:value => nil)
          is_expected.to contain_tempest_config('compute/build_interval').with(:value => nil)
          is_expected.to contain_tempest_config('compute-feature-enabled/attach_encrypted_volume').with(:value => false)
          is_expected.to contain_tempest_config('identity/admin_role').with(:value => nil)
          is_expected.to contain_tempest_config('identity/auth_version').with(:value => 'v2')
          is_expected.to contain_tempest_config('identity/alt_password').with(:value => nil)
          is_expected.to contain_tempest_config('identity/alt_password').with_secret( true )
          is_expected.to contain_tempest_config('identity/alt_project_name').with(:value => nil)
          is_expected.to contain_tempest_config('identity/alt_username').with(:value => nil)
          is_expected.to contain_tempest_config('identity/password').with(:value => nil)
          is_expected.to contain_tempest_config('identity/password').with_secret( true )
          is_expected.to contain_tempest_config('identity/project_name').with(:value => nil)
          is_expected.to contain_tempest_config('identity/uri').with(:value => nil)
          is_expected.to contain_tempest_config('identity/uri_v3').with(:value => nil)
          is_expected.to contain_tempest_config('identity/username').with(:value => nil)
          is_expected.to contain_tempest_config('identity/ca_certificates_file').with(:value => nil)
          is_expected.to contain_tempest_config('identity/disable_ssl_certificate_validation').with(:value => nil)
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
          is_expected.to contain_tempest_config('service_available/gnocchi').with(:value => false)
          is_expected.to contain_tempest_config('service_available/horizon').with(:value => true)
          is_expected.to contain_tempest_config('service_available/neutron').with(:value => true)
          is_expected.to contain_tempest_config('service_available/mistral').with(:value => false)
          is_expected.to contain_tempest_config('service_available/nova').with(:value => true)
          is_expected.to contain_tempest_config('service_available/sahara').with(:value => false)
          is_expected.to contain_tempest_config('service_available/murano').with(:value => false)
          is_expected.to contain_tempest_config('service_available/swift').with(:value => false)
          is_expected.to contain_tempest_config('service_available/trove').with(:value => false)
          is_expected.to contain_tempest_config('service_available/ironic').with(:value => false)
          is_expected.to contain_tempest_config('service_available/zaqar').with(:value => false)
          is_expected.to contain_tempest_config('service_available/designate').with(:value => false)
          is_expected.to contain_tempest_config('whitebox/db_uri').with(:value => nil)
          is_expected.to contain_tempest_config('cli/cli_dir').with(:value => nil)
          is_expected.to contain_tempest_config('oslo_concurrency/lock_path').with(:value => '/var/lib/tempest')
          is_expected.to contain_tempest_config('DEFAULT/debug').with(:value => false)
          is_expected.to contain_tempest_config('DEFAULT/log_file').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('DEFAULT/use_stderr').with(:value => true)
          is_expected.to contain_tempest_config('DEFAULT/use_syslog').with(:value => false)
          is_expected.to contain_tempest_config('DEFAULT/logging_context_format_string').with_value('<SERVICE DEFAULT>')
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

        it 'sets up virtualenv for tempest' do
          is_expected.to contain_exec('setup-venv').with(
              :command => 'virtualenv /var/lib/tempest/.venv && /var/lib/tempest/.venv/bin/pip install -U -r requirements.txt',
              :cwd     => '/var/lib/tempest',
              :unless  => 'test -d /var/lib/tempest/.venv',
              :path    => ['/bin', '/usr/bin', '/usr/local/bin']
          )
        end
      end
    end
  end

  shared_examples 'tempest with plugins packages' do
    let :pre_condition do
      "include ::glance
       class { 'neutron': rabbit_password => 'passw0rd' }"
    end

    context 'with when managing tests packages for keystone (required service)' do
      let :params do
        { :manage_tests_packages => true }
      end

      describe "should install keystone tests package" do
        it { expect { is_expected.to contain_package('python-keystone-tests') } }
        it { expect { is_expected.to_not contain_package('python-aodh-tests') } }
      end
    end

    context 'with when managing tests packages for aodh (optional service)' do
      let :params do
        { :manage_tests_packages => true,
          :aodh_available        => true }
      end

      describe "should install aodh tests package" do
        it { expect { is_expected.to contain_package('python-aodh-tests') } }
      end
    end

    context 'with when managing tests packages for neutron (optional service)' do
      let :params do
        { :manage_tests_packages => true,
          :neutron_available        => true }
      end

      describe "should install neutron and *aas tests packages" do
        it { expect { is_expected.to contain_package('python-neutron-tests') } }
        it { expect { is_expected.to contain_package('python-neutron-fwaas-tests') } }
        it { expect { is_expected.to contain_package('python-neutron-lbaas-tests') } }
        it { expect { is_expected.to contain_package('python-neutron-vpnaas-tests') } }
        it { expect { is_expected.to contain_package('python-horizon-tests') } }
      end
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts({
          :concat_basedir => '/var/lib/puppet/concat',
          :processorcount => 2
        }))
      end
      let(:platform_params) do
        case facts[:osfamily]
        when 'Debian'
          { :dev_packages => ['python-dev',
                              'libxslt1-dev',
                              'libxml2-dev',
                              'libssl-dev',
                              'libffi-dev',
                              'patch',
                              'gcc',
                              'python-virtualenv' ] }
        when 'RedHat'
          { :dev_packages => ['python-devel',
                              'libxslt-devel',
                              'libxml2-devel',
                              'openssl-devel',
                              'libffi-devel',
                              'patch',
                              'gcc'] }
        end
      end

      it_behaves_like 'tempest'
      it_behaves_like 'tempest with plugins packages'
    end
  end
end
