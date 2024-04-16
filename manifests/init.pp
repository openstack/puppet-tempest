# class for installing and configuring tempest
#
# The class checks out the tempest repo and sets the basic config.
#
# Note that only parameters for which values are provided will be
# managed in tempest.conf.
#
#  [*package_ensure*]
#  (optional) The state of tempest packages
#   Defaults to 'present'
#  [*tempest_workspace*]
#   Deafults to '/var/lib/tempest'
#  [*install_from_source*]
#   Defaults to true
#  [*git_clone*]
#   Defaults to true
#  [*tempest_repo_uri*]
#   Defaults to 'https://opendev.org/openstack/tempest'
#  [*tempest_repo_revision*]
#   Defaults to undef
#  [*tempest_clone_path*]
#   Defaults to '/var/lib/tempest'
#  [*tempest_clone_owner*]
#   Defaults to 'root'
#  [*setup_venv*]
#   Defaults to false
#  [*configure_images*]
#   Defaults to true
#  [*image_name*]
#   Defaults to undef
#  [*image_name_alt*]
#   Defaults to undef
#  [*configure_networks*]
#   Defaults to true
#  [*l2gw_switch*]
#   Defaults to $facts['os_service_default']
#  [*public_network_name*]
#   Defaults to undef
#  [*neutron_api_extensions*]
#   Defaults to $facts['os_service_default']
#  [*identity_uri*]
#   Defaults to $facts['os_service_default']
#  [*identity_uri_v3*]
#   Defaults to $facts['os_service_default']
#  [*lock_path*]
#   Defaults to '/var/lib/tempest'
#  [*log_file*]
#   Defaults to $facts['os_service_default']
#  [*debug*]
#   Defaults to $facts['os_service_default']
#  [*use_stderr*]
#   Defaults to true
#  [*use_syslog*]
#   Defaults to $facts['os_service_default']
#  [*logging_context_format_string*]
#   Defaults to $facts['os_service_default']
#  [*http_timeout*]
#   Defaults to $facts['os_service_default']
#  [*username*]
#   Defaults to undef
#  [*password*]
#   Defaults to undef
#  [*project_name*]
#   Defaults to undef
#  [*user_domain_name*]
#   Defaults to $facts['os_service_default']
#  [*project_domain_name*]
#   Defaults to $facts['os_service_default']
#  [*alt_username*]
#   Defaults to undef
#  [*alt_password*]
#   Defaults to undef
#  [*alt_project_name*]
#   Defaults to undef
#  [*alt_user_domain_name*]
#   Defaults to $facts['os_service_default']
#  [*alt_project_domain_name*]
#   Defaults to $facts['os_service_default']
#  [*admin_username*]
#   Defaults to undef
#  [*admin_password*]
#   Defaults to undef
#  [*admin_project_name*]
#   Defaults to undef
#  [*admin_role*]
#   Defaults to $facts['os_service_default']
#  [*admin_domain_name*]
#   Defaults to $facts['os_service_default']
#  [*admin_user_domain_name*]
#   Defaults to $facts['os_service_default']
#  [*admin_project_domain_name*]
#   Defaults to $facts['os_service_default']
#  [*admin_system*]
#   Defaults to $facts['os_service_default']
#  [*default_credentials_domain_name*]
#   Defaults to $facts['os_service_default']
#  [*image_ref*]
#   Defaults to undef
#  [*image_ref_alt*]
#   Defaults to undef
#  [*image_ssh_user*]
#   Defaults to undef
#  [*image_alt_ssh_user*]
#   Defaults to undef
#  [*run_ssh*]
#   Defaults to false
#  [*ssh_key_type*]
#   Defaults to $facts['os_service_default']
#  [*flavor_name*]
#   Defaults to undef
#  [*flavor_name_alt*]
#   Defaults to undef
#  [*flavor_ref*]
#   Defaults to undef
#  [*flavor_ref_alt*]
#   Defaults to undef
#  [*resize_available*]
#   Defaults to $facts['os_service_default']
#  [*use_dynamic_credentials*]
#   Defaults to $facts['os_service_default']
#  [*public_network_id*]
#   Defaults to undef
#  [*public_router_id*]
#   Defaults to undef
#  [*cinder_available*]
#   Defaults to true
#  [*cinder_backup_available*]
#   Defaults to false
#  [*glance_available*]
#   Defaults to true
#  [*heat_available*]
#   Defaults to false
#  [*ceilometer_available*]
#   Defaults to false
#  [*aodh_available*]
#   Defaults to false
#  [*gnocchi_available*]
#   Defaults to false
#  [*sg_core_available*]
#   Defaults to false
#  [*designate_available*]
#   Defaults to false
#  [*horizon_available*]
#   Defaults to true
#  [*neutron_available*]
#   Defaults to true
#  [*neutron_bgpvpn_available*]
#   Defaults to false
#  [*neutron_l2gw_available*]
#   Defaults to true
#  [*neutron_vpnaas_available*]
#   Defaults to false
#  [*neutron_dr_available*]
#   Defaults to false
#  [*nova_available*]
#   Defaults to true
#  [*watcher_available*]
#   Defaults to false
#  [*zaqar_available*]
#   Defaults to false
#  [*mistral_available*]
#   Defaults to false
#  [*vitrage_available*]
#   Defaults to false
#  [*run_service_broker_tests*]
#   Defaults to $facts['os_service_default']
#  [*swift_available*]
#   Defaults to false
#  [*trove_available*]
#   Defaults to false
#  [*ironic_available*]
#   Defaults to false
#  [*ironic_inspector_available*]
#   Defaults to false
#  [*octavia_available*]
#   Defaults to false
#  [*barbican_available*]
#   Defaults to false
#  [*manila_available*]
#   Defaults to false
#  [*barbican_enforce_scope*]
#   Defaults to $facts['os_service_default']
#  [*cinder_enforce_scope*]
#   Defaults to $facts['os_service_default']
#  [*glance_enforce_scope*]
#   Defaults to $facts['os_service_default']
#  [*keystone_enforce_scope*]
#   Defaults to $facts['os_service_default']
#  [*neutron_enforce_scope*]
#   Defaults to $facts['os_service_default']
#  [*nova_enforce_scope*]
#   Defaults to $facts['os_service_default']
#  [*placement_enforce_scope*]
#   Defaults to $facts['os_service_default']
#  [*ironic_enforce_scope*]
#   Defaults to $facts['os_service_default']
#  [*ironic_inspector_enforce_scope*]
#   Defaults to $facts['os_service_default']
#  [*designate_enforce_scope*]
#   Defaults to $facts['os_service_default']
#  [*octavia_enforce_scope*]
#   Defaults to $facts['os_service_default']
#  [*manila_enforce_scope*]
#   Defaults to $facts['os_service_default']
#  [*compute_min_microversion*]
#   Defaults to $facts['os_service_default']
#  [*compute_max_microversion*]
#   Defaults to $facts['os_service_default']
#  [*placement_min_microversion*]
#   Defaults to $facts['os_service_default']
#  [*placement_max_microversion*]
#   Defaults to $facts['os_service_default']
#  [*volume_min_microversion*]
#   Defaults to $facts['os_service_default']
#  [*volume_max_microversion*]
#   Defaults to $facts['os_service_default']
#  [*key_manager_min_microversion*]
#   Defaults to $facts['os_service_default']
#  [*key_manager_max_microversion*]
#   Defaults to $facts['os_service_default']
#  [*baremetal_min_microversion*]
#   Defaults to $facts['os_service_default']
#  [*baremetal_max_microversion*]
#   Defaults to $facts['os_service_default']
#  [*share_min_microversion*]
#   Defaults to $facts['os_service_default']
#  [*share_max_microversion*]
#   Defaults to $facts['os_service_default']
#  [*keystone_v3*]
#   Defaults to $facts['os_service_default']
#  [*auth_version*]
#   Defaults to $facts['os_service_default']
#  [*img_file*]
#   Defaults to '/var/lib/tempest/cirros-0.4.0-x86_64-disk.img'
#  [*img_disk_format*]
#   Defaults to $facts['os_service_default']
#  [*dashboard_url*]
#   Defaults to $facts['os_service_default']
#  [*disable_dashboard_ssl_validation*]
#   Defaults to $facts['os_service_default']
#  [*compute_build_interval*]
#   Defaults to $facts['os_service_default']
#  [*compute_build_timeout*]
#   Defaults to $facts['os_service_default']
#  [*image_build_interval*]
#   Defaults to $facts['os_service_default']
#  [*image_build_timeout*]
#   Defaults to $facts['os_service_default']
#  [*network_build_interval*]
#   Defaults to $facts['os_service_default']
#  [*network_build_timeout*]
#   Defaults to $facts['os_service_default']
#  [*volume_build_interval*]
#   Defaults to $facts['os_service_default']
#  [*volume_build_timeout*]
#   Defaults to $facts['os_service_default']
#  [*object_storage_build_timeout*]
#   Defaults to $facts['os_service_default']
#  [*ca_certificates_file*]
#   Defaults to $facts['os_service_default']
#  [*disable_ssl_validation*]
#   Defaults to $facts['os_service_default']
#  [*manage_tests_packages*]
#   Defaults to false
#  [*attach_encrypted_volume*]
#   Defaults to false
#  [*tempest_roles*]
#   Defaults to $facts['os_service_default']
#  [*reseller_admin_role*]
#   Defaults to $facts['os_service_default']
#  [*db_flavor_ref*]
#   Valid primary flavor to use in Trove tests.
#   Defaults to undef
#  [*db_flavor_name*]
#   Defaults to undef
#  [*designate_nameservers*]
#   Defaults to $facts['os_service_default']
#  [*heat_image_ref*]
#   Defaults to undef
#  [*heat_image_name*]
#   Defaults to undef
#  [*heat_flavor_ref*]
#   Defaults to undef
#  [*heat_flavor_name*]
#   Defaults to undef
#  [*baremetal_driver*]
#   Defaults to $facts['os_service_default']
#  [*baremetal_enabled_hardware_types*]
#   Defaults to $facts['os_service_default']
#  [*load_balancer_member_role*]
#   Defaults to $facts['os_service_default']
#  [*load_balancer_admin_role*]
#   Defaults to $facts['os_service_default']
#  [*load_balancer_observer_role*]
#   Defaults to $facts['os_service_default']
#  [*load_balancer_global_observer_role*]
#   Defaults to $facts['os_service_default']
#  [*load_balancer_test_with_noop*]
#   Defaults to $facts['os_service_default']
#  [*share_multitenancy_enabled*]
#   Defaults to $facts['os_service_default']
#  [*share_enable_protocols*]
#   Defaults to $facts['os_service_default']
#  [*share_multi_backend*]
#   Defaults to $facts['os_service_default']
#  [*share_capability_storage_protocol*]
#   Defaults to $facts['os_service_default']
#  [*metric_backends*]
#   Defaults to $facts['os_service_default']
#  [*alarm_backend*]
#   Defaults to $facts['os_service_default']
#
# DEPREACTED PARAMETERS
#  [*glance_v2*]
#   Defaults to true
#  [*tempest_config_file*]
#   Defaults to undef
#  [*cli_dir*]
#   Defaults to undef 
#  [*login_url*]
#   Defaults to undef
#  [*ec2api_available*]
#   Defaults to undef
#  [*ec2api_tester_roles*]
#   Defaults to undef
#  [*aws_ec2_url*]
#   Defaults to undef
#  [*aws_region*]
#   Defaults to undef
#  [*aws_image_id*]
#   Defaults to undef
#  [*aws_ebs_image_id*]
#   Defaults to undef
#  [*murano_available*]
#   Defualts to undef
#  [*sahara_available*]
#   Defualts to undef
#  [*sahara_plugins*]
#   Defualts to undef
#
class tempest(
  $package_ensure                           = 'present',
  Stdlib::Absolutepath $tempest_workspace   = '/var/lib/tempest',
  Boolean $install_from_source              = true,
  Boolean $git_clone                        = true,

  # Clone config
  #
  $tempest_repo_uri                         = 'https://opendev.org/openstack/tempest',
  $tempest_repo_revision                    = undef,
  Stdlib::Absolutepath $tempest_clone_path  = '/var/lib/tempest',
  $tempest_clone_owner                      = 'root',

  Boolean $setup_venv                       = false,

  # Glance image config
  #
  Boolean $configure_images                 = true,
  Optional[String[1]] $image_name           = undef,
  Optional[String[1]] $image_name_alt       = undef,

  # Neutron network config
  #
  Boolean $configure_networks               = true,
  Optional[String[1]] $public_network_name  = undef,
  $neutron_api_extensions                   = $facts['os_service_default'],

  # Horizon dashboard config
  $dashboard_url                            = $facts['os_service_default'],
  $disable_dashboard_ssl_validation         = $facts['os_service_default'],

  # tempest.conf parameters
  #
  $identity_uri                             = $facts['os_service_default'],
  $identity_uri_v3                          = $facts['os_service_default'],
  $lock_path                                = '/var/lib/tempest',
  $log_file                                 = $facts['os_service_default'],
  $debug                                    = $facts['os_service_default'],
  $use_stderr                               = true,
  $use_syslog                               = $facts['os_service_default'],
  $logging_context_format_string            = $facts['os_service_default'],
  $http_timeout                             = $facts['os_service_default'],
  $attach_encrypted_volume                  = false,
  # non admin user
  $username                                 = undef,
  $password                                 = undef,
  $project_name                             = undef,
  $user_domain_name                         = $facts['os_service_default'],
  $project_domain_name                      = $facts['os_service_default'],
  # another non-admin user
  $alt_username                             = undef,
  $alt_password                             = undef,
  $alt_project_name                         = undef,
  $alt_user_domain_name                     = $facts['os_service_default'],
  $alt_project_domain_name                  = $facts['os_service_default'],
  # admin user
  $admin_username                           = undef,
  $admin_password                           = undef,
  $admin_project_name                       = undef,
  $admin_role                               = $facts['os_service_default'],
  $admin_domain_name                        = $facts['os_service_default'],
  $admin_user_domain_name                   = $facts['os_service_default'],
  $admin_project_domain_name                = $facts['os_service_default'],
  $admin_system                             = $facts['os_service_default'],
  $default_credentials_domain_name          = $facts['os_service_default'],
  # roles fo the users created by tempest
  $tempest_roles                            = $facts['os_service_default'],
  $reseller_admin_role                      = $facts['os_service_default'],
  # image information
  $image_ref                                = undef,
  $image_ref_alt                            = undef,
  $image_ssh_user                           = undef,
  $image_alt_ssh_user                       = undef,
  $flavor_ref                               = undef,
  $flavor_ref_alt                           = undef,
  Optional[String[1]] $flavor_name          = undef,
  Optional[String[1]] $flavor_name_alt      = undef,
  $compute_build_interval                   = $facts['os_service_default'],
  $compute_build_timeout                    = $facts['os_service_default'],
  $image_build_interval                     = $facts['os_service_default'],
  $image_build_timeout                      = $facts['os_service_default'],
  $network_build_interval                   = $facts['os_service_default'],
  $network_build_timeout                    = $facts['os_service_default'],
  $volume_build_interval                    = $facts['os_service_default'],
  $volume_build_timeout                     = $facts['os_service_default'],
  $object_storage_build_timeout             = $facts['os_service_default'],
  $run_ssh                                  = false,
  $ssh_key_type                             = $facts['os_service_default'],
  # testing features that are supported
  $resize_available                         = $facts['os_service_default'],
  $use_dynamic_credentials                  = $facts['os_service_default'],
  $l2gw_switch                              = $facts['os_service_default'],
  # neutron config
  $public_network_id                        = undef,
  $public_router_id                         = undef,
  # Trove config
  $db_flavor_ref                            = undef,
  Optional[String[1]] $db_flavor_name       = undef,
  # Service configuration
  Boolean $cinder_available                 = true,
  Boolean $cinder_backup_available          = false,
  Boolean $glance_available                 = true,
  Boolean $heat_available                   = false,
  Boolean $ceilometer_available             = false,
  Boolean $aodh_available                   = false,
  Boolean $gnocchi_available                = false,
  Boolean $sg_core_available                = false,
  Boolean $designate_available              = false,
  Boolean $horizon_available                = true,
  Boolean $neutron_available                = true,
  Boolean $neutron_bgpvpn_available         = false,
  Boolean $neutron_l2gw_available           = false,
  Boolean $neutron_vpnaas_available         = false,
  Boolean $neutron_dr_available             = false,
  Boolean $nova_available                   = true,
  Boolean $swift_available                  = false,
  Boolean $trove_available                  = false,
  Boolean $ironic_available                 = false,
  Boolean $ironic_inspector_available       = false,
  Boolean $watcher_available                = false,
  Boolean $zaqar_available                  = false,
  Boolean $mistral_available                = false,
  Boolean $vitrage_available                = false,
  Boolean $octavia_available                = false,
  Boolean $barbican_available               = false,
  Boolean $manila_available                 = false,
  # scope enforcements
  $barbican_enforce_scope                   = $facts['os_service_default'],
  $cinder_enforce_scope                     = $facts['os_service_default'],
  $glance_enforce_scope                     = $facts['os_service_default'],
  $keystone_enforce_scope                   = $facts['os_service_default'],
  $neutron_enforce_scope                    = $facts['os_service_default'],
  $nova_enforce_scope                       = $facts['os_service_default'],
  $placement_enforce_scope                  = $facts['os_service_default'],
  $ironic_enforce_scope                     = $facts['os_service_default'],
  $ironic_inspector_enforce_scope           = $facts['os_service_default'],
  $designate_enforce_scope                  = $facts['os_service_default'],
  $octavia_enforce_scope                    = $facts['os_service_default'],
  $manila_enforce_scope                     = $facts['os_service_default'],
  # microversions
  $compute_min_microversion                 = $facts['os_service_default'],
  $compute_max_microversion                 = $facts['os_service_default'],
  $placement_min_microversion               = $facts['os_service_default'],
  $placement_max_microversion               = $facts['os_service_default'],
  $volume_min_microversion                  = $facts['os_service_default'],
  $volume_max_microversion                  = $facts['os_service_default'],
  $key_manager_min_microversion             = $facts['os_service_default'],
  $key_manager_max_microversion             = $facts['os_service_default'],
  $baremetal_min_microversion               = $facts['os_service_default'],
  $baremetal_max_microversion               = $facts['os_service_default'],
  $share_min_microversion                   = $facts['os_service_default'],
  $share_max_microversion                   = $facts['os_service_default'],
  $keystone_v3                              = $facts['os_service_default'],
  $auth_version                             = $facts['os_service_default'],
  $run_service_broker_tests                 = $facts['os_service_default'],
  $ca_certificates_file                     = $facts['os_service_default'],
  $disable_ssl_validation                   = $facts['os_service_default'],
  Boolean $manage_tests_packages            = false,
  # scenario options
  $img_file                                 = '/var/lib/tempest/cirros-0.4.0-x86_64-disk.img',
  $img_disk_format                          = $facts['os_service_default'],
  # designate options
  $designate_nameservers                    = $facts['os_service_default'],
  # heat options
  $heat_image_ref                           = undef,
  Optional[String[1]] $heat_image_name      = undef,
  $heat_flavor_ref                          = undef,
  Optional[String[1]] $heat_flavor_name     = undef,
  # ironic options
  $baremetal_driver                         = $facts['os_service_default'],
  $baremetal_enabled_hardware_types         = $facts['os_service_default'],
  # octavia options
  $load_balancer_member_role                = $facts['os_service_default'],
  $load_balancer_admin_role                 = $facts['os_service_default'],
  $load_balancer_observer_role              = $facts['os_service_default'],
  $load_balancer_global_observer_role       = $facts['os_service_default'],
  $load_balancer_test_with_noop             = $facts['os_service_default'],
  # manila options
  $share_multitenancy_enabled               = $facts['os_service_default'],
  $share_enable_protocols                   = $facts['os_service_default'],
  $share_multi_backend                      = $facts['os_service_default'],
  $share_capability_storage_protocol        = $facts['os_service_default'],
  # telemetry options
  $metric_backends                          = $facts['os_service_default'],
  $alarm_backend                            = $facts['os_service_default'],
  # DEPRECATED PARAMETERS
  $glance_v2                                = undef,
  $tempest_config_file                      = undef,
  $cli_dir                                  = undef,
  $login_url                                = undef,
  Optional[Boolean] $ec2api_available       = undef,
  Optional[Boolean] $murano_available       = undef,
  Optional[Boolean] $sahara_available       = undef,
  $ec2api_tester_roles                      = undef,
  $aws_ec2_url                              = undef,
  $aws_region                               = undef,
  $aws_image_id                             = undef,
  $aws_ebs_image_id                         = undef,
  $sahara_plugins                           = undef,
) {

  [ 'glance_v2', 'cli_dir', 'login_url' ].each |String $deprecated_opt| {
    if getvar($deprecated_opt) != undef {
      warning("The ${deprecated_opt} parameter has been deprecated and will be removed in a future release")
    }
  }
  if $tempest_config_file != undef {
    warning('The tempest_config_file parameter has been deprecated and has no effect')
  }

  [ 'neutron_bgpvpn_available', 'neutron_vpnaas_available', 'neutron_dr_available' ].each |$opt| {
    if getvar($opt) != undef {
      warning("The ${opt} parameter has no effect now. Use the neutron_api_extensions parameter instead.")
    }
  }

  if $ec2api_available {
    warning('EC2API support has been deprecated and has no effect now.')
  }
  if $murano_available {
    warning('Murano support has been deprecated and has no effect now.')
  }
  if $sahara_available {
    warning('Sahara support has been deprecated and has no effect now.')
  }

  [
    'ec2api_available', 'murano_available', 'sahara_available',
    'ec2api_tester_roles', 'aws_ec2_url', 'aws_region',
    'aws_image_id', 'aws_ebs_image_id', 'sahara_plugins'
  ].each |String $deprecated_plugin_opt| {
    if getvar($deprecated_plugin_opt) != undef {
      warning("The ${deprecated_plugin_opt} parameter has been deprecated and has no effect.")
    }
  }


  include tempest::params

  include openstacklib::openstackclient

  if $install_from_source {
    ensure_packages(['git'])
    ensure_packages($tempest::params::dev_packages)

    if $::tempest::params::pip_package_name {
      ensure_packages('pip', {
        name => $::tempest::params::pip_package_name,
      })
      Package['pip'] -> Exec['install-tox']
    } else {
      warning('pip package is not available in this distribution.')
    }

    exec { 'install-tox':
      command => [$tempest::params::pip_command, 'install', '-U', 'tox'],
      unless  => 'which tox',
      path    => ['/bin','/usr/bin','/usr/local/bin'],
    }

    if $git_clone {
      vcsrepo { $tempest_clone_path:
        ensure   => 'present',
        source   => $tempest_repo_uri,
        revision => $tempest_repo_revision,
        provider => 'git',
        require  => Package['git'],
        user     => $tempest_clone_owner,
      }
      Vcsrepo<||> -> Tempest_config<||>
    }

    if $setup_venv {
      # virtualenv will be installed along with tox
      exec { 'create-venv':
        command => ['virtualenv', '-p', 'python3', "${tempest_clone_path}/.venv"],
        creates => "${tempest_clone_path}/.venv",
        path    => ['/bin', '/usr/bin', '/usr/local/bin'],
        require => [
          Exec['install-tox'],
          Package[$tempest::params::dev_packages],
        ],
      }
      exec { 'install-tempest':
        command     => ["${tempest_clone_path}/.venv/bin/${tempest::params::pip_command}", 'install', '-U', '-r', 'requirements.txt'],
        cwd         => $tempest_clone_path,
        refreshonly => true,
        subscribe   => Exec['create-venv'],
      }

      if $git_clone {
        Vcsrepo<||> -> Exec['create-venv']
      }
    }

    $tempest_conf = "${tempest_clone_path}/etc/tempest.conf"
  } else {

    package { 'tempest':
      ensure => $package_ensure,
      name   => $::tempest::params::package_name,
      tag    => ['openstack', 'tempest-package'],
    }

    # Create tempest workspace by running tempest init.
    # It will generate etc/tempest.conf, logs and tempest_lock folder
    # in tempest workspace
    exec {'tempest-workspace':
      command     => ['tempest', 'init', $tempest_workspace],
      path        => ['/bin', '/usr/bin'],
      refreshonly => true,
      require     => Package['tempest'],
    }
    Package<| tag == 'tempest-package' |> -> Exec['tempest-workspace']
    Package['tempest'] ~> Exec['tempest-workspace']
    Exec['tempest-workspace'] -> Tempest_config<||>

    $tempest_conf = "${tempest_workspace}/etc/tempest.conf"
  }

  Tempest_config {
    path => $tempest_conf,
  }

  tempest_config {
    'service-clients/http_timeout':                    value => $http_timeout;
    'auth/admin_domain_name':                          value => $admin_domain_name;
    'auth/admin_project_domain_name':                  value => $admin_project_domain_name;
    'auth/admin_user_domain_name':                     value => $admin_user_domain_name;
    'auth/default_credentials_domain_name':            value => $default_credentials_domain_name;
    'auth/admin_password':                             value => $admin_password, secret => true;
    'auth/admin_project_name':                         value => $admin_project_name;
    'auth/admin_username':                             value => $admin_username;
    'auth/admin_system':                               value => $admin_system;
    'auth/tempest_roles':                              value => join(any2array($tempest_roles), ',');
    'auth/use_dynamic_credentials':                    value => $use_dynamic_credentials;
    'object-storage/reseller_admin_role':              value => $reseller_admin_role;
    'compute/flavor_ref':                              value => $flavor_ref;
    'compute/flavor_ref_alt':                          value => $flavor_ref_alt;
    'compute/image_ref':                               value => $image_ref;
    'compute/image_ref_alt':                           value => $image_ref_alt;
    'compute/build_interval':                          value => $compute_build_interval;
    'compute/build_timeout':                           value => $compute_build_timeout;
    'image/build_interval':                            value => $image_build_interval;
    'image/build_timeout':                             value => $image_build_timeout;
    'network/build_interval':                          value => $network_build_interval;
    'network/build_timeout':                           value => $network_build_timeout;
    'volume/build_interval':                           value => $volume_build_interval;
    'volume/build_timeout':                            value => $volume_build_timeout;
    'object-storage/build_timeout':                    value => $object_storage_build_timeout;
    'validation/image_ssh_user':                       value => $image_ssh_user;
    'validation/image_alt_ssh_user':                   value => $image_alt_ssh_user;
    'validation/run_validation':                       value => $run_ssh;
    'validation/ssh_key_type':                         value => $ssh_key_type;
    'identity/admin_role':                             value => $admin_role;
    'identity/alt_password':                           value => $alt_password, secret => true;
    'identity/alt_project_name':                       value => $alt_project_name;
    'identity/alt_username':                           value => $alt_username;
    'identity/alt_project_domain_name':                value => $project_domain_name;
    'identity/alt_user_domain_name':                   value => $user_domain_name;
    'identity/password':                               value => $password, secret => true;
    'identity/project_name':                           value => $project_name;
    'identity/username':                               value => $username;
    'identity/project_domain_name':                    value => $project_domain_name;
    'identity/user_domain_name':                       value => $user_domain_name;
    'identity/uri':                                    value => $identity_uri;
    'identity/uri_v3':                                 value => $identity_uri_v3;
    'identity/auth_version':                           value => $auth_version;
    'identity/ca_certificates_file':                   value => $ca_certificates_file;
    'identity/disable_ssl_certificate_validation':     value => $disable_ssl_validation;
    'identity-feature-enabled/api_v3':                 value => $keystone_v3;
    'image-feature-enabled/api_v2':                    value => pick($glance_v2, $facts['os_service_default']);
    'l2gw/l2gw_switch':                                value => $l2gw_switch;
    'network-feature-enabled/api_extensions':          value => join(any2array($neutron_api_extensions), ',');
    'network/public_network_id':                       value => $public_network_id;
    'network/public_router_id':                        value => $public_router_id;
    'dashboard/login_url':                             value => pick($login_url, $facts['os_service_default']);
    'dashboard/dashboard_url':                         value => $dashboard_url;
    'dashboard/disable_ssl_certificate_validation':    value => $disable_dashboard_ssl_validation;
    'database/db_flavor_ref':                          value => $db_flavor_ref;
    'service_available/cinder':                        value => $cinder_available;
    'volume-feature-enabled/backup':                   value => $cinder_backup_available;
    'service_available/glance':                        value => $glance_available;
    'service_available/heat':                          value => $heat_available;
    'service_available/ceilometer':                    value => $ceilometer_available;
    'service_available/aodh':                          value => $aodh_available;
    'service_available/gnocchi':                       value => $gnocchi_available;
    'service_available/sg_core':                       value => $sg_core_available;
    'service_available/barbican':                      value => $barbican_available;
    'service_available/manila':                        value => $manila_available;
    'service_available/designate':                     value => $designate_available;
    'service_available/horizon':                       value => $horizon_available;
    'service_available/neutron':                       value => $neutron_available;
    'service_available/mistral':                       value => $mistral_available;
    'service_available/vitrage':                       value => $vitrage_available;
    'service_available/nova':                          value => $nova_available;
    'service_available/swift':                         value => $swift_available;
    'service_available/trove':                         value => $trove_available;
    'service_available/ironic':                        value => $ironic_available;
    'service_available/ironic_inspector':              value => $ironic_inspector_available;
    'service_available/watcher':                       value => $watcher_available;
    'service_available/zaqar':                         value => $zaqar_available;
    'service_available/octavia':                       value => $octavia_available;
    'enforce_scope/barbican':                          value => $barbican_enforce_scope;
    'enforce_scope/cinder':                            value => $cinder_enforce_scope;
    'enforce_scope/designate':                         value => $designate_enforce_scope;
    'enforce_scope/glance':                            value => $glance_enforce_scope;
    'enforce_scope/ironic':                            value => $ironic_enforce_scope;
    'enforce_scope/ironic_inspector':                  value => $ironic_inspector_enforce_scope;
    'enforce_scope/keystone':                          value => $keystone_enforce_scope;
    'identity-feature-enabled/enforce_scope':          value => $keystone_enforce_scope;
    'enforce_scope/manila':                            value => $manila_enforce_scope;
    'enforce_scope/neutron':                           value => $neutron_enforce_scope;
    'enforce_scope/nova':                              value => $nova_enforce_scope;
    'enforce_scope/octavia':                           value => $octavia_enforce_scope;
    'enforce_scope/placement':                         value => $placement_enforce_scope;
    'compute/min_microversion':                        value => $compute_min_microversion;
    'compute/max_microversion':                        value => $compute_max_microversion;
    'placement/min_microversion':                      value => $placement_min_microversion;
    'placement/max_microversion':                      value => $placement_max_microversion;
    'volume/min_microversion':                         value => $volume_min_microversion;
    'volume/max_microversion':                         value => $volume_max_microversion;
    'key_manager/min_microversion':                    value => $key_manager_min_microversion;
    'key_manager/max_microversion':                    value => $key_manager_max_microversion;
    'baremetal/min_microversion':                      value => $baremetal_min_microversion;
    'baremetal/max_microversion':                      value => $baremetal_max_microversion;
    'share/min_api_microversion':                      value => $share_min_microversion;
    'share/max_api_microversion':                      value => $share_max_microversion;
    'cli/cli_dir':                                     value => pick($cli_dir, $facts['os_service_default']);
    'scenario/img_file':                               value => $img_file;
    'scenario/img_disk_format':                        value => $img_disk_format;
    'service_broker/run_service_broker_tests':         value => $run_service_broker_tests;
    'compute-feature-enabled/attach_encrypted_volume': value => $attach_encrypted_volume;
    'compute-feature-enabled/resize':                  value => $resize_available;
    # designate-tempest-plugin
    'dns/nameservers':                                 value => join(any2array($designate_nameservers), ',');
    # heat-tempest-plugin
    'heat_plugin/auth_url':                            value => $identity_uri_v3;
    # TODO(tkajinam): auth_version does not affect vN format (eg v3) and
    #                 the heading v should be removed.
    'heat_plugin/auth_version':                        value => regsubst($auth_version, '^v(\\d+)$', '\\1');
    'heat_plugin/admin_username':                      value => $admin_username;
    'heat_plugin/admin_password':                      value => $admin_password, secret => true;
    'heat_plugin/admin_project_name':                  value => $admin_project_name;
    'heat_plugin/admin_user_domain_name':              value => $admin_user_domain_name;
    'heat_plugin/admin_project_domain_name':           value => $admin_project_domain_name;
    'heat_plugin/username':                            value => $username;
    'heat_plugin/password':                            value => $password, secret => true;
    'heat_plugin/project_name':                        value => $project_name;
    'heat_plugin/user_domain_name':                    value => $user_domain_name;
    'heat_plugin/project_domain_name':                 value => $project_domain_name;
    'heat_plugin/image_ref':                           value => $heat_image_ref;
    'heat_plugin/instance_type':                       value => $heat_flavor_ref;
    'heat_plugin/minimal_image_ref':                   value => $image_ref;
    'heat_plugin/minimal_instance_type':               value => $flavor_ref;
    # ironic-tempest-plugin
    'baremetal/driver':                                value => $baremetal_driver;
    'baremetal/enabled_hardware_types':                value => $baremetal_enabled_hardware_types;
    # octavia-tempest-plugin
    'load_balancer/member_role':                       value => $load_balancer_member_role;
    'load_balancer/admin_role':                        value => $load_balancer_admin_role;
    'load_balancer/observer_role':                     value => $load_balancer_observer_role;
    'load_balancer/global_observer_role':              value => $load_balancer_global_observer_role;
    'load_balancer/test_with_noop':                    value => $load_balancer_test_with_noop;
    # manila-tempest-plugin
    'share/multitenancy_enabled':                      value => $share_multitenancy_enabled;
    'share/enable_protocols':                          value => join(any2array($share_enable_protocols), ',');
    'share/multi_backend':                             value => $share_multi_backend;
    'share/capability_storage_protocol':               value => $share_capability_storage_protocol;
    # telemetry-tempest-plugin
    'telemetry_services/metric_backends':              value => join(any2array($metric_backends), ',');
    'telemetry_services/alarm_backend':                value => $alarm_backend;
  }

  # TODO(tkajinam): Remove this after 2024.1 release
  tempest_config {
    'barbican_rbac_scope_verification/enforce_scope': ensure => absent;
  }

  tempest_config {
    # ec2api-tempest-plugin
    'service_available/ec2api':                ensure => absent;
    'aws/ec2_url':                             ensure => absent;
    'aws/aws_region':                          ensure => absent;
    'aws/image_id':                            ensure => absent;
    'aws/ebs_image_id':                        ensure => absent;
    'aws/instance_type':                       ensure => absent;
    'aws/instance_type_alt':                   ensure => absent;
    'aws/aws_secret':                          ensure => absent;
    'aws/aws_access':                          ensure => absent;
    # murano-tempest-plugin
    'service_available/murano':                ensure => absent;
    # sahara-tempest-plugin
    'service_available/sahara':                ensure => absent;
    'data-processing-feature-enabled/plugins': ensure => absent;
  }

  oslo::concurrency { 'tempest_config': lock_path => $lock_path }

  oslo::log { 'tempest_config':
    debug                         => $debug,
    log_file                      => $log_file,
    use_stderr                    => $use_stderr,
    use_syslog                    => $use_syslog,
    logging_context_format_string => $logging_context_format_string
  }

  if $manage_tests_packages {
    if ($aodh_available or $ceilometer_available or $gnocchi_available) and $::tempest::params::python_telemetry_tests {
      package { 'python-telemetry-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_telemetry_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $cinder_available and $::tempest::params::python_cinder_tests {
      package { 'python-cinder-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_cinder_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $glance_available and $::tempest::params::python_glance_tests {
      package { 'python-glance-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_glance_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $heat_available and $::tempest::params::python_heat_tests {
      package { 'python-heat-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_heat_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if ($ironic_available or $ironic_inspector_available) and $::tempest::params::python_ironic_tests {
      package { 'python-ironic-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_ironic_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $::tempest::params::python_keystone_tests {
      package { 'python-keystone-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_keystone_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $neutron_available and $::tempest::params::python_neutron_tests {
      package { 'python-neutron-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_neutron_tests,
        tag    => ['openstack', 'tempest-package'],
      }
      if $neutron_l2gw_available and $::tempest::params::python_l2gw_tests {
        package { 'python-networking-l2gw-tests-tempest':
          ensure => present,
          name   => $::tempest::params::python_l2gw_tests,
          tag    => ['openstack', 'tempest-package'],
        }
      }
    }
    if $trove_available and $::tempest::params::python_trove_tests {
      package { 'python-trove-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_trove_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $watcher_available and $::tempest::params::python_watcher_tests {
      package { 'python-watcher-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_watcher_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $zaqar_available and $::tempest::params::python_zaqar_tests {
      package { 'python-zaqar-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_zaqar_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $mistral_available and $::tempest::params::python_mistral_tests {
      package { 'python-mistral-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_mistral_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $vitrage_available and $::tempest::params::python_vitrage_tests {
      package { 'python-vitrage-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_vitrage_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $designate_available and $::tempest::params::python_designate_tests {
      package { 'python-designate-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_designate_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $octavia_available and $::tempest::params::python_octavia_tests {
      package { 'python-octavia-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_octavia_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $barbican_available and $::tempest::params::python_barbican_tests {
      package { 'python-barbican-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_barbican_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $manila_available and $::tempest::params::python_manila_tests {
      package { 'python-manila-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_manila_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }

  }

  if ! $flavor_ref and $flavor_name {
    tempest_flavor_id_setter { 'compute/flavor_ref':
      ensure            => present,
      tempest_conf_path => $tempest_conf,
      flavor_name       => $flavor_name,
    }
    Tempest_config<||> -> Tempest_flavor_id_setter['compute/flavor_ref']
    Keystone_user_role<||> -> Tempest_flavor_id_setter['compute/flavor_ref']

    tempest_flavor_id_setter { 'heat_plugin/minimal_instance_type':
      ensure            => present,
      tempest_conf_path => $tempest_conf,
      flavor_name       => $flavor_name,
    }
    Tempest_config<||> -> Tempest_flavor_id_setter['heat_plugin/minimal_instance_type']
    Keystone_user_role<||> -> Tempest_flavor_id_setter['heat_plugin/minimal_instance_type']
  } elsif ($flavor_name and $flavor_ref) {
    fail('flavor_ref and flavor_name are both set: please set only one of them')
  }

  if ! $flavor_ref_alt and $flavor_name_alt {
    tempest_flavor_id_setter { 'compute/flavor_ref_alt':
      ensure            => present,
      tempest_conf_path => $tempest_conf,
      flavor_name       => $flavor_name_alt,
    }
    Tempest_config<||> -> Tempest_flavor_id_setter['compute/flavor_ref_alt']
    Keystone_user_role<||> -> Tempest_flavor_id_setter['compute/flavor_ref_alt']
  } elsif ($flavor_name_alt and $flavor_ref_alt) {
    fail('flavor_ref_alt and flavor_name_alt are both set: please set only one of them')
  }

  if ! $db_flavor_ref and $db_flavor_name {
    tempest_flavor_id_setter { 'database/db_flavor_ref':
      ensure            => present,
      tempest_conf_path => $tempest_conf,
      flavor_name       => $db_flavor_name,
    }
    Tempest_config<||> -> Tempest_flavor_id_setter['database/db_flavor_ref']
    Keystone_user_role<||> -> Tempest_flavor_id_setter['database/db_flavor_ref']
  } elsif ($db_flavor_name and $db_flavor_ref) {
    fail('db_flavor_ref and db_flavor_name are both set: please set only one of them')
  }

  if !$heat_flavor_ref and $heat_flavor_name {
    tempest_flavor_id_setter { 'heat_plugin/instance_type':
      ensure            => present,
      tempest_conf_path => $tempest_conf,
      flavor_name       => $heat_flavor_name,
    }
    Tempest_config<||> -> Tempest_flavor_id_setter['heat_plugin/instance_type']
    Keystone_user_role<||> -> Tempest_flavor_id_setter['heat_plugin/instance_type']
  } elsif ($heat_flavor_name and $heat_flavor_ref) {
    fail('heat_flavor_ref and heat_flavor_name are both set: please set only one of them')
  }

  if $configure_images {
    if ! $image_ref and $image_name {
      # If the image id was not provided, look it up via the image name
      # and set the value in the conf file.
      tempest_glance_id_setter { 'compute/image_ref':
        ensure            => present,
        tempest_conf_path => $tempest_conf,
        image_name        => $image_name,
      }
      Tempest_config<||> -> Tempest_glance_id_setter['compute/image_ref']
      Keystone_user_role<||> -> Tempest_glance_id_setter['compute/image_ref']
      tempest_glance_id_setter { 'heat_plugin/minimal_image_ref':
        ensure            => present,
        tempest_conf_path => $tempest_conf,
        image_name        => $image_name,
      }
      Tempest_config<||> -> Tempest_glance_id_setter['heat_plugin/minimal_image_ref']
      Keystone_user_role<||> -> Tempest_glance_id_setter['heat_plugin/minimal_image_ref']
    } elsif ($image_name and $image_ref) or (! $image_name and ! $image_ref) {
      fail('A value for either image_name or image_ref must be provided.')
    }

    if ! $image_ref_alt and $image_name_alt {
      tempest_glance_id_setter { 'compute/image_ref_alt':
        ensure            => present,
        tempest_conf_path => $tempest_conf,
        image_name        => $image_name_alt,
      }
      Tempest_config<||> -> Tempest_glance_id_setter['compute/image_ref_alt']
      Keystone_user_role<||> -> Tempest_glance_id_setter['compute/image_ref_alt']
    } elsif ($image_name_alt and $image_ref_alt) or (! $image_name_alt and ! $image_ref_alt) {
      fail('A value for either image_name_alt or image_ref_alt must be provided.')
    }

    if ! $heat_image_ref and $heat_image_name {
      tempest_glance_id_setter { 'heat_plugin/image_ref':
        ensure            => present,
        tempest_conf_path => $tempest_conf,
        image_name        => $heat_image_name,
      }
      Tempest_config<||> -> Tempest_glance_id_setter['heat_plugin/image_ref']
      Keystone_user_role<||> -> Tempest_glance_id_setter['heat_plugin/image_ref']
    } elsif ($heat_image_name and $heat_image_ref) {
      fail('heat_image_ref and heat_image_name are both set: please set only one of them')
    }
  }

  if $neutron_available and $configure_networks {
    if ! $public_network_id and $public_network_name {
      tempest_neutron_net_id_setter { 'network/public_network_id':
        ensure            => present,
        tempest_conf_path => $tempest_conf,
        network_name      => $public_network_name,
      }
      Tempest_config<||> -> Tempest_neutron_net_id_setter['network/public_network_id']
      Keystone_user_role<||> -> Tempest_neutron_net_id_setter['network/public_network_id']
    } elsif ($public_network_name and $public_network_id) or (! $public_network_name and ! $public_network_id) {
      fail('A value for either public_network_id or public_network_name \
  must be provided.')
    }
  }
}
