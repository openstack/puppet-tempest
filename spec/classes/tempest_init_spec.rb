require 'spec_helper'

describe 'tempest' do
  shared_examples 'tempest' do

    let :pre_condition do
      "include glance
       include neutron"
    end

    context 'without parameters' do
      let :params do
        {
          :configure_networks => false,
        }
      end

      describe "should raise error" do
        it { expect { is_expected.to contain_class('tempest::params') }.to raise_error(Puppet::Error, /A value for either image_name or image_ref/) }
      end
    end

    context 'with image_name parameters' do
      let :params do
        {
          :configure_networks => false,
          :image_name         => 'image_name'
        }
      end

      describe "should raise error" do
        it { expect { is_expected.to contain_class('tempest::params') }.to raise_error(Puppet::Error, /A value for either image_name_alt or image_ref_alt/) }
      end
    end

    context 'with image_ref parameters' do
      let :params do
        {
          :configure_networks => false,
          :image_ref          => '4c423fc6-87f7-4e6d-9d3c-abc13058ae5b',
          :image_ref_alt      => '4c423fc6-87f7-4e6d-9d3c-abc13058ae5b'
        }
      end

      it 'configures image_ref' do
        is_expected.to contain_tempest_config('compute/image_ref').with_value('4c423fc6-87f7-4e6d-9d3c-abc13058ae5b')
        is_expected.to contain_tempest_config('heat_plugin/minimal_image_ref').with_value('4c423fc6-87f7-4e6d-9d3c-abc13058ae5b')
      end
    end

    context 'with image_name' do
      let :params do
        {
          :configure_networks => false,
          :image_name         => 'cirros',
          :image_name_alt     => 'cirros'
        }
      end

      it 'uses a resource to configure image_ref from image_name' do
        is_expected.to contain_tempest_glance_id_setter('compute/image_ref').with_image_name('cirros')
        is_expected.to contain_tempest_glance_id_setter('heat_plugin/minimal_image_ref').with_image_name('cirros')
      end
    end

    context 'with image_ref and image_name parameters' do
      let :params do
        {
          :configure_networks => false,
          :image_name         => 'cirros',
          :image_name_alt     => 'cirros',
          :image_ref          => '4c423fc6-87f7-4e6d-9d3c-abc13058ae5b',
          :image_ref_alt      => '4c423fc6-87f7-4e6d-9d3c-abc13058ae5b'
        }
      end

      it_raises 'a Puppet::Error', /either image_name or image_ref/
    end

    context 'with public_network_id parameter' do
      let :params do
        {
          :configure_images  => false,
          :public_network_id => '4c423fc6-87f7-4e6d-9d3c-abc13058ae5b'
        }
      end

      it 'configures public_network_id' do
        is_expected.to contain_tempest_config('network/public_network_id').with_value('4c423fc6-87f7-4e6d-9d3c-abc13058ae5b')
      end
    end

    context 'with public_network_name parameter' do
      let :params do
        {
          :configure_images    => false,
          :public_network_name => 'public'
        }
      end

      it 'uses a resource to configure public_network_id from public_network_name' do
        is_expected.to contain_tempest_neutron_net_id_setter('network/public_network_id').with_network_name('public')
      end
    end

    context 'with public_network_id and public_network_name' do
      let :params do
        {
          :configure_images    => false,
          :public_network_name => 'public',
          :public_network_id   => '4c423fc6-87f7-4e6d-9d3c-abc13058ae5b'
        }
      end

      it_raises 'a Puppet::Error', /either public_network_id or public_network_name/
    end

    context 'without configures images' do
      let :params do
        { :configure_images  => false }
      end

      describe "should raise error" do
        it { expect { is_expected.to contain_class('tempest::params') }.to raise_error(Puppet::Error, /A value for either public_network_id or public_network_name/) }
      end
    end

    context 'with reseller_admin_role' do
      let :params do
        {
          :configure_images    => false,
          :configure_networks  => false,
          :reseller_admin_role => 'admin',
        }
      end

      it 'properly sets reseller_admin_role in tempest.conf' do
        is_expected.to contain_tempest_config('object-storage/reseller_admin_role').with_value('admin')
      end
    end

    context 'with tempest_roles' do
      let :params do
        {
          :configure_images   => false,
          :configure_networks => false,
          :tempest_roles      => ['Member', 'creator'],
        }
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
          :heat_image_name     => 'heat image name',
          :public_network_name => 'network name',
          :install_from_source => true,
          :setup_venv          => true
        }
      end

      describe "should install tempest" do
        it 'installs packages' do

          is_expected.to contain_package('git')

          platform_params[:dev_packages].each do |package|
            is_expected.to contain_package("#{package}")
          end

          is_expected.to contain_class('tempest::params')

          is_expected.to contain_vcsrepo('/var/lib/tempest').with(
            :ensure   => 'present',
            :source   => 'https://opendev.org/openstack/tempest',
            :revision => nil,
            :provider => 'git',
            :require  => 'Package[git]',
            :user     => 'root'
          )
        end

        it { should contain_class('openstacklib::openstackclient') }

        it 'configure tempest config' do
          is_expected.to contain_tempest_config('service-clients/http_timeout').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('auth/admin_domain_name').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('auth/admin_project_domain_name').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('auth/admin_user_domain_name').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('auth/default_credentials_domain_name').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('auth/admin_password').with_secret( true )
          is_expected.to contain_tempest_config('auth/admin_project_name').with(:value => nil)
          is_expected.to contain_tempest_config('auth/admin_username').with(:value => nil)
          is_expected.to contain_tempest_config('auth/admin_system').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('auth/tempest_roles').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('auth/use_dynamic_credentials').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('object-storage/reseller_admin_role').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('compute/flavor_ref').with(:value => nil)
          is_expected.to contain_tempest_config('compute/flavor_ref_alt').with(:value => nil)
          is_expected.to contain_tempest_config('compute/image_ref').with(:value => nil)
          is_expected.to contain_tempest_config('compute/image_ref_alt').with(:value => nil)
          is_expected.to contain_tempest_config('compute/build_interval').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('compute/build_timeout').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('image/build_interval').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('image/build_timeout').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('network/build_interval').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('network/build_timeout').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('volume/build_interval').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('volume/build_timeout').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('object-storage/build_timeout').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('compute-feature-enabled/attach_encrypted_volume').with(:value => false)
          is_expected.to contain_tempest_config('compute-feature-enabled/resize').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('validation/image_ssh_user').with(:value => nil)
          is_expected.to contain_tempest_config('validation/image_alt_ssh_user').with(:value => nil)
          is_expected.to contain_tempest_config('validation/run_validation').with(:value => false)
          is_expected.to contain_tempest_config('validation/ssh_key_type').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('identity/admin_role').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('identity/auth_version').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('identity/alt_password').with(:value => nil)
          is_expected.to contain_tempest_config('identity/alt_password').with_secret( true )
          is_expected.to contain_tempest_config('identity/alt_project_name').with(:value => nil)
          is_expected.to contain_tempest_config('identity/alt_username').with(:value => nil)
          is_expected.to contain_tempest_config('identity/alt_project_domain_name').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('identity/alt_user_domain_name').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('identity/password').with(:value => nil)
          is_expected.to contain_tempest_config('identity/password').with_secret( true )
          is_expected.to contain_tempest_config('identity/project_name').with(:value => nil)
          is_expected.to contain_tempest_config('identity/username').with(:value => nil)
          is_expected.to contain_tempest_config('identity/project_domain_name').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('identity/user_domain_name').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('identity/uri').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('identity/uri_v3').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('identity/ca_certificates_file').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('identity/disable_ssl_certificate_validation').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('identity-feature-enabled/api_v3').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('image-feature-enabled/api_v2').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('l2gw/l2gw_switch').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('network-feature-enabled/api_extensions').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('network/public_network_id').with(:value => nil)
          is_expected.to contain_tempest_config('network/public_router_id').with(:value => nil)
          is_expected.to contain_tempest_config('dashboard/dashboard_url').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('dashboard/disable_ssl_certificate_validation').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('database/db_flavor_ref').with(:value => nil)
          is_expected.to contain_tempest_config('service_available/cinder').with(:value => true)
          is_expected.to contain_tempest_config('volume-feature-enabled/backup').with(:value => false)
          is_expected.to contain_tempest_config('service_available/glance').with(:value => true)
          is_expected.to contain_tempest_config('service_available/heat').with(:value => false)
          is_expected.to contain_tempest_config('service_available/ceilometer').with(:value => false)
          is_expected.to contain_tempest_config('service_available/aodh').with(:value => false)
          is_expected.to contain_tempest_config('service_available/gnocchi').with(:value => false)
          is_expected.to contain_tempest_config('service_available/sg_core').with(:value => false)
          is_expected.to contain_tempest_config('service_available/horizon').with(:value => true)
          is_expected.to contain_tempest_config('service_available/neutron').with(:value => true)
          is_expected.to contain_tempest_config('service_available/mistral').with(:value => false)
          is_expected.to contain_tempest_config('service_available/vitrage').with(:value => false)
          is_expected.to contain_tempest_config('service_available/nova').with(:value => true)
          is_expected.to contain_tempest_config('service_available/swift').with(:value => false)
          is_expected.to contain_tempest_config('service_available/trove').with(:value => false)
          is_expected.to contain_tempest_config('service_available/ironic').with(:value => false)
          is_expected.to contain_tempest_config('service_available/ironic_inspector').with(:value => false)
          is_expected.to contain_tempest_config('service_available/watcher').with(:value => false)
          is_expected.to contain_tempest_config('service_available/zaqar').with(:value => false)
          is_expected.to contain_tempest_config('service_available/designate').with(:value => false)
          is_expected.to contain_tempest_config('service_available/octavia').with(:value => false)
          is_expected.to contain_tempest_config('service_available/barbican').with(:value => false)
          is_expected.to contain_tempest_config('service_available/manila').with(:value => false)
          is_expected.to contain_tempest_config('enforce_scope/barbican').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('enforce_scope/cinder').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('enforce_scope/glance').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('enforce_scope/keystone').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('identity-feature-enabled/enforce_scope').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('enforce_scope/neutron').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('enforce_scope/nova').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('enforce_scope/placement').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('enforce_scope/ironic').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('enforce_scope/ironic_inspector').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('enforce_scope/designate').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('enforce_scope/octavia').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('enforce_scope/manila').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('compute/min_microversion').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('compute/max_microversion').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('placement/min_microversion').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('placement/max_microversion').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('volume/min_microversion').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('volume/max_microversion').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('key_manager/min_microversion').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('key_manager/max_microversion').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('baremetal/min_microversion').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('baremetal/max_microversion').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('share/min_api_microversion').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('share/max_api_microversion').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('compute/catalog_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('identity/catalog_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('image/catalog_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('network/catalog_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('object_store/catalog_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('placement/catalog_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('volume/catalog_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('heat_plugin/catalog_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('alarming/catalog_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('metric/catalog_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('baremetal/catalog_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('dns/catalog_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('load_balancer/catalog_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('share/catalog_type').with_value('<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('dns/nameservers').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('heat_plugin/auth_url').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('heat_plugin/auth_version').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('heat_plugin/admin_password').with_secret( true )
          is_expected.to contain_tempest_config('heat_plugin/admin_project_name').with(:value => nil)
          is_expected.to contain_tempest_config('heat_plugin/admin_username').with(:value => nil)
          is_expected.to contain_tempest_config('heat_plugin/admin_project_domain_name').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('heat_plugin/admin_user_domain_name').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('heat_plugin/password').with(:value => nil)
          is_expected.to contain_tempest_config('heat_plugin/password').with_secret( true )
          is_expected.to contain_tempest_config('heat_plugin/project_name').with(:value => nil)
          is_expected.to contain_tempest_config('heat_plugin/username').with(:value => nil)
          is_expected.to contain_tempest_config('heat_plugin/image_ref').with(:value => nil)
          is_expected.to contain_tempest_config('heat_plugin/instance_type').with(:value => nil)
          is_expected.to contain_tempest_config('heat_plugin/minimal_image_ref').with(:value => nil)
          is_expected.to contain_tempest_config('heat_plugin/minimal_instance_type').with(:value => nil)
          is_expected.to contain_tempest_config('baremetal/driver').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('baremetal/enabled_drivers').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('baremetal/enabled_hardware_types').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('load_balancer/member_role').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('load_balancer/admin_role').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('load_balancer/observer_role').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('load_balancer/global_observer_role').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('load_balancer/test_with_noop').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('share/multitenancy_enabled').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('share/enable_protocols').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('share/multi_backend').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('telemetry_services/metric_backends').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('telemetry_services/alarm_backend').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('share/capability_storage_protocol').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_oslo__concurrency('tempest_config').with(
            :lock_path => '/var/lib/tempest'
          )
          is_expected.to contain_tempest_config('scenario/img_file').with(:value => '/var/lib/tempest/cirros-0.4.0-x86_64-disk.img')
          is_expected.to contain_tempest_config('scenario/img_disk_format').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_tempest_config('service_broker/run_service_broker_tests').with(:value => '<SERVICE DEFAULT>')
          is_expected.to contain_oslo__log('tempest_config').with(
            :debug                         => '<SERVICE DEFAULT>',
            :log_file                      => '<SERVICE DEFAULT>',
            :use_stderr                    => true,
            :use_syslog                    => '<SERVICE DEFAULT>',
            :logging_context_format_string => '<SERVICE DEFAULT>'
          )

          is_expected.not_to contain_tempest_config('magnum/keypair_id').with_value('default')
        end

        it 'set glance id' do
          is_expected.to contain_tempest_glance_id_setter('compute/image_ref').with(
            :ensure            => 'present',
            :tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
            :image_name        => 'image name',
          )
          is_expected.to contain_tempest_glance_id_setter('compute/image_ref_alt').with(
            :ensure            => 'present',
            :tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
            :image_name        => 'image name alt',
          )
          is_expected.to contain_tempest_glance_id_setter('heat_plugin/image_ref').with(
            :ensure            => 'present',
            :tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
            :image_name        => 'heat image name',
          )
          is_expected.to contain_tempest_glance_id_setter('heat_plugin/minimal_image_ref').with(
            :ensure            => 'present',
            :tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
            :image_name        => 'image name',
          )
        end

        it 'neutron net id' do
          is_expected.to contain_tempest_neutron_net_id_setter('network/public_network_id').with(
            :ensure            => 'present',
            :tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
            :network_name      => 'network name',
          )
        end

        it 'sets up virtualenv for tempest' do
          is_expected.to contain_exec('create-venv').with(
            :command => ['python3', '-m', 'venv', '/var/lib/tempest/.venv'],
            :creates => '/var/lib/tempest/.venv',
            :path    => ['/bin', '/usr/bin', '/usr/local/bin']
          )
        end

        it 'installs tempest into the virtualenv' do
          is_expected.to contain_exec('install-tempest').with(
            :command     => [
              'pytho3', '-m' 'venv', '/var/lib/tempest/.venv'
            ],
            :command     => [
              "/var/lib/tempest/.venv/bin/#{platform_params[:pip_command]}", 'install',
              '-U', '-r', 'requirements.txt'
            ],
            :cwd         => '/var/lib/tempest',
            :refreshonly => true,
          )
        end
      end
    end

    context 'with img_file set' do
      let :params do
        {
          :configure_images   => false,
          :configure_networks => false,
          :img_file           => '/home/stack/myimage.img'
        }
      end

      it 'sets image_file based on img_dir and img_file' do
        is_expected.to contain_tempest_config('scenario/img_file').with(:value => '/home/stack/myimage.img')
      end
    end

    context 'install Tempest from package' do
      let :params do
        {
          :configure_images    => false,
          :configure_networks  => false,
          :install_from_source => false,
        }
      end

      it 'checks for tempest package' do
        is_expected.to contain_package('tempest').with(
          :ensure => 'present',
          :name   => platform_params[:package_name],
          :tag    => ['openstack', 'tempest-package'],
        )
      end
      it 'creates tempest workspace' do
        is_expected.to contain_exec('tempest-workspace').with(
          :command     => ['tempest', 'init', '/var/lib/tempest'],
          :path        => ['/bin', '/usr/bin'],
          :refreshonly => true,
          :subscribe   => 'Package[tempest]'
        )
      end
    end

    context 'tempest workspace customization' do
      let :params do
        {
          :configure_images    => false,
          :configure_networks  => false,
          :tempest_workspace   => '/tmp/tempest',
          :install_from_source => false
        }
      end

      it 'supports customizes tempest workspace' do
        is_expected.to contain_exec('tempest-workspace').with(
          :command => ['tempest', 'init', '/tmp/tempest'],
        )
      end
    end

    context 'with flavor_name parameters' do
      let :params do
        {
          :configure_images   => false,
          :configure_networks => false,
          :flavor_name        => 'm1.tiny',
          :flavor_name_alt    => 'm1.nano',
          :db_flavor_name     => 'm1.micro',
          :heat_flavor_name   => 'm1.small',
        }
      end

      it "sets flavor id using setter" do
        is_expected.to contain_tempest_flavor_id_setter('compute/flavor_ref').with(
          :ensure            => 'present',
          :tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
          :flavor_name       => 'm1.tiny',
        )
        is_expected.to contain_tempest_flavor_id_setter('compute/flavor_ref_alt').with(
          :ensure            => 'present',
          :tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
          :flavor_name       => 'm1.nano',
        )
        is_expected.to contain_tempest_flavor_id_setter('database/db_flavor_ref').with(
          :ensure            => 'present',
          :tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
          :flavor_name       => 'm1.micro',
        )
        is_expected.to contain_tempest_flavor_id_setter('heat_plugin/instance_type').with(
          :ensure            => 'present',
          :tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
          :flavor_name       => 'm1.small',
        )
        is_expected.to contain_tempest_flavor_id_setter('heat_plugin/minimal_instance_type').with(
          :ensure            => 'present',
          :tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
          :flavor_name       => 'm1.tiny',
        )
      end
    end
  end

  shared_examples 'tempest with plugins packages' do
    let :pre_condition do
      "include glance
       include neutron"
    end

    let :params do
      {
        :configure_images      => false,
        :configure_networks    => false,
        :manage_tests_packages => true
      }
    end

    context 'with when managing tests packages for keystone (required service)' do
      it "should install keystone tests package" do
        is_expected.to contain_package('python-keystone-tests-tempest').with(
          :name => platform_params[:python_keystone_tests]
        )
      end

      it "should not install optional heat tests package" do
        is_expected.to_not contain_package('python-heat-tests-tempest')
      end

      it "should install neutron but not *aas tests packages" do
        is_expected.to contain_package('python-neutron-tests-tempest').with(
          :name => platform_params[:python_neutron_tests]
        )
        is_expected.to_not contain_package('python-networking-l2gw-tests-tempest')
      end
    end

    context 'with when managing tests packages for heat (optional service)' do
      before :each do
        params.merge!({ :heat_available => true })
      end

      it "should install heat tests package if available" do
        is_expected.to contain_package('python-heat-tests-tempest').with(
          :name => platform_params[:python_heat_tests]
        )
      end
    end
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end
      let(:platform_params) do
        case facts[:os]['family']
        when 'Debian'
          { :dev_packages          => ['python3-dev',
                                       'libxslt1-dev',
                                       'libxml2-dev',
                                       'libssl-dev',
                                       'libffi-dev',
                                       'patch',
                                       'gcc'],
            :package_name          => 'tempest',
            :pip_command           => 'pip3',
            :python_heat_tests     => 'heat-tempest-plugin',
            :python_keystone_tests => 'keystone-tempest-plugin',
            :python_neutron_tests  => 'neutron-tempest-plugin',
          }
        when 'RedHat'
          { :dev_packages          => ['python3-devel',
                                       'libxslt-devel',
                                       'libxml2-devel',
                                       'openssl-devel',
                                       'libffi-devel',
                                       'patch',
                                       'gcc'],
            :package_name          => 'openstack-tempest',
            :pip_command           => 'pip3',
            :python_heat_tests     => 'python3-heat-tests-tempest',
            :python_keystone_tests => 'python3-keystone-tests-tempest',
            :python_neutron_tests  => 'python3-neutron-tests-tempest',
          }
        end
      end

      it_behaves_like 'tempest'
      it_behaves_like 'tempest with plugins packages'
    end
  end
end
