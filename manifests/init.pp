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
#  [*tempest_config_file*]
#   Defaults to '/var/lib/tempest/etc/tempest.conf'
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
#   Defaults to undef
#  [*public_network_name*]
#   Defaults to undef
#  [*neutron_api_extensions*]
#   Defaults to undef
#  [*identity_uri*]
#   Defaults to undef
#  [*identity_uri_v3*]
#   Defaults to undef
#  [*cli_dir*]
#   Defaults to undef
#  [*lock_path*]
#   Defaults to '/var/lib/tempest'
#  [*log_file*]
#   Defaults to $::os_service_default
#  [*debug*]
#   Defaults to false
#  [*use_stderr*]
#   Defaults to true
#  [*use_syslog*]
#   Defaults to false
#  [*logging_context_format_string*]
#   Defaults to $::os_service_default
#  [*username*]
#   Defaults to undef
#  [*password*]
#   Defaults to undef
#  [*project_name*]
#   Defaults to undef
#  [*alt_username*]
#   Defaults to undef
#  [*alt_password*]
#   Defaults to undef
#  [*alt_project_name*]
#   Defaults to undef
#  [*admin_username*]
#   Defaults to undef
#  [*admin_password*]
#   Defaults to undef
#  [*admin_project_name*]
#   Defaults to undef
#  [*admin_role*]
#   Defaults to undef
#  [*admin_domain_name*]
#   Defaults to $::os_service_default
#  [*admin_user_domain_name*]
#   Defaults to $::os_service_default
#  [*admin_project_domain_name*]
#   Defaults to $::os_service_default
#  [*admin_system*]
#   Defaults to $::os_service_default
#  [*default_credentials_domain_name*]
#   Defaults to $::os_service_default
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
#   Defaults to $::os_service_default
#  [*flavor_name*]
#   Defaults to undef
#  [*flavor_name_alt*]
#   Defaults to undef
#  [*flavor_ref*]
#   Defaults to undef
#  [*flavor_ref_alt*]
#   Defaults to undef
#  [*whitebox_db_uri*]
#   Defaults to undef
#  [*resize_available*]
#   Defaults to false
#  [*use_dynamic_credentials*]
#   Defaults to undef
#  [*public_network_id*]
#   Defaults to undef
#  [*public_router_id*]
#   Defaults to ''
#  [*sahara_plugins*]
#   (optional) List of enabled Sahara plugins
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
#  [*designate_available*]
#   Defaults to false
#  [*horizon_available*]
#   Defaults to true
#  [*neutron_available*]
#   Defaults to false
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
#  [*murano_available*]
#   Defaults to false
#  [*watcher_available*]
#   Defaults to false
#  [*zaqar_available*]
#   Defaults to false
#  [*ec2api_available*]
#   Defaults to false
#  [*mistral_available*]
#   Defaults to false
#  [*vitrage_available*]
#   Defaults to false
#  [*run_service_broker_tests*]
#   Defaults to false
#  [*sahara_available*]
#   Defaults to false
#  [*swift_available*]
#   Defaults to false
#  [*trove_available*]
#   Defaults to false
#  [*ironic_available*]
#   Defaults to false
#  [*octavia_available*]
#   Defaults to false
#  [*barbican_available*]
#   Defaults to false
#  [*cinder_enforce_scope*]
#   Defaults to $::os_service_default
#  [*glance_enforce_scope*]
#   Defaults to $::os_service_default
#  [*keystone_enforce_scope*]
#   Defaults to $::os_service_default
#  [*neutron_enforce_scope*]
#   Defaults to $::os_service_default
#  [*nova_enforce_scope*]
#   Defaults to $::os_service_default
#  [*keystone_v3*]
#   Defaults to true
#  [*auth_version*]
#   Defaults to 'v3'
#  [*img_file*]
#   Defaults to '/var/lib/tempest/cirros-0.4.0-x86_64-disk.img'
#  [*img_disk_format*]
#   Defaults to $::os_service_default
#  [*login_url*]
#   Defaults to undef
#  [*dashboard_url*]
#   Defaults to undef
#  [*disable_dashboard_ssl_validation*]
#   Defaults to undef
#  [*compute_build_interval*]
#   Defaults to undef
#  [*ca_certificates_file*]
#   Defaults to undef
#  [*disable_ssl_validation*]
#   Defaults to undef
#  [*designate_nameservers*]
#   Defaults to undef
#  [*manage_tests_packages*]
#   Defaults to false
#  [*attach_encrypted_volume*]
#   Defaults to false
#  [*tempest_roles*]
#   Should be an array.
#   Defaults to $::os_service_default
#  [*db_flavor_ref*]
#   Valid primary flavor to use in Trove tests.
#   Defaults to $::os_service_default
#  [*db_flavor_name*]
#   Defaults to undef
#  [*baremetal_driver*]
#   Defaults to 'fake'
#  [*baremetal_enabled_hardware_types*]
#   Defaults to 'ipmi'
#  [*ec2api_tester_roles*]
#   Defaults to 'Member'
#  [*load_balancer_member_role*]
#   Defaults to $::os_service_default
#  [*load_balancer_admin_role*]
#   Defaults to $::os_service_default
#  [*load_balancer_observer_role*]
#   Defaults to $::os_service_default
#  [*load_balancer_global_observer_role*]
#   Defaults to $::os_service_default
#  [*load_balancer_test_with_noop*]
#   Defaults to $::os_service_default
#
# DEPREACTED PARAMETERS
#  [*glance_v1*]
#   Defaults to false
#  [*glance_v2*]
#   Defaults to true
#
class tempest(
  $package_ensure                     = 'present',
  $tempest_workspace                  = '/var/lib/tempest',
  $install_from_source                = true,
  $git_clone                          = true,
  $tempest_config_file                = '/var/lib/tempest/etc/tempest.conf',

  # Clone config
  #
  $tempest_repo_uri                   = 'https://opendev.org/openstack/tempest',
  $tempest_repo_revision              = undef,
  $tempest_clone_path                 = '/var/lib/tempest',
  $tempest_clone_owner                = 'root',

  $setup_venv                         = false,

  # Glance image config
  #
  $configure_images                   = true,
  $image_name                         = undef,
  $image_name_alt                     = undef,

  # Neutron network config
  #
  $configure_networks                 = true,
  $public_network_name                = undef,
  $neutron_api_extensions             = undef,

  # Horizon dashboard config
  $login_url                          = undef,
  $dashboard_url                      = undef,
  $disable_dashboard_ssl_validation   = undef,

  # tempest.conf parameters
  #
  $identity_uri                       = undef,
  $identity_uri_v3                    = undef,
  $cli_dir                            = undef,
  $lock_path                          = '/var/lib/tempest',
  $log_file                           = $::os_service_default,
  $debug                              = false,
  $use_stderr                         = true,
  $use_syslog                         = false,
  $logging_context_format_string      = $::os_service_default,
  $attach_encrypted_volume            = false,
  # non admin user
  $username                           = undef,
  $password                           = undef,
  $project_name                       = undef,
  # another non-admin user
  $alt_username                       = undef,
  $alt_password                       = undef,
  $alt_project_name                   = undef,
  # admin user
  $admin_username                     = undef,
  $admin_password                     = undef,
  $admin_project_name                 = undef,
  $admin_role                         = undef,
  $admin_domain_name                  = $::os_service_default,
  $admin_user_domain_name             = $::os_service_default,
  $admin_project_domain_name          = $::os_service_default,
  $admin_system                       = $::os_service_default,
  $default_credentials_domain_name    = $::os_service_default,
  # roles fo the users created by tempest
  $tempest_roles                      = $::os_service_default,
  # image information
  $image_ref                          = undef,
  $image_ref_alt                      = undef,
  $image_ssh_user                     = undef,
  $image_alt_ssh_user                 = undef,
  $flavor_ref                         = undef,
  $flavor_ref_alt                     = undef,
  $flavor_name                        = undef,
  $flavor_name_alt                    = undef,
  $compute_build_interval             = undef,
  $run_ssh                            = false,
  $ssh_key_type                       = $::os_service_default,
  # whitebox
  $whitebox_db_uri                    = undef,
  # testing features that are supported
  $resize_available                   = false,
  $use_dynamic_credentials            = undef,
  $l2gw_switch                        = undef,
  # neutron config
  $public_network_id                  = undef,
  # Upstream has a bad default - set it to empty string.
  $public_router_id                   = '',
  # Sahara config
  $sahara_plugins                     = undef,
  # Trove config
  $db_flavor_ref                      = $::os_service_default,
  $db_flavor_name                     = undef,
  # Service configuration
  $cinder_available                   = true,
  $cinder_backup_available            = false,
  $glance_available                   = true,
  $heat_available                     = false,
  $ceilometer_available               = false,
  $aodh_available                     = false,
  $gnocchi_available                  = false,
  $designate_available                = false,
  $horizon_available                  = true,
  $neutron_available                  = false,
  $neutron_bgpvpn_available           = false,
  $neutron_l2gw_available             = false,
  $neutron_vpnaas_available           = false,
  $neutron_dr_available               = false,
  $nova_available                     = true,
  $murano_available                   = false,
  $sahara_available                   = false,
  $swift_available                    = false,
  $trove_available                    = false,
  $ironic_available                   = false,
  $watcher_available                  = false,
  $zaqar_available                    = false,
  $ec2api_available                   = false,
  $mistral_available                  = false,
  $vitrage_available                  = false,
  $octavia_available                  = false,
  $barbican_available                 = false,
  $cinder_enforce_scope               = $::os_service_default,
  $glance_enforce_scope               = $::os_service_default,
  $keystone_enforce_scope             = $::os_service_default,
  $neutron_enforce_scope              = $::os_service_default,
  $nova_enforce_scope                 = $::os_service_default,
  $keystone_v3                        = true,
  $auth_version                       = 'v3',
  $run_service_broker_tests           = false,
  $ca_certificates_file               = undef,
  $disable_ssl_validation             = undef,
  $manage_tests_packages              = false,
  # scenario options
  $img_file                           = '/var/lib/tempest/cirros-0.4.0-x86_64-disk.img',
  $img_disk_format                    = $::os_service_default,
  # designate options
  $designate_nameservers              = undef,
  # ironic options
  $baremetal_driver                   = 'fake',
  $baremetal_enabled_hardware_types   = 'ipmi',
  # ec2api options
  $ec2api_tester_roles                = ['Member'],
  # octavia options
  $load_balancer_member_role          = $::os_service_default,
  $load_balancer_admin_role           = $::os_service_default,
  $load_balancer_observer_role        = $::os_service_default,
  $load_balancer_global_observer_role = $::os_service_default,
  $load_balancer_test_with_noop       = $::os_service_default,
  # DEPRECATED PARAMETERS
  $glance_v1                          = undef,
  $glance_v2                          = undef,
) {

  if $glance_v1 != undef {
    warning('The glance_v1 parameter has been deprecated and will be removed in a future release.')
  }

  if $glance_v2 != undef {
    warning('The glance_v2 parameter has been deprecated and will be removed in a future release.')
  }

  include tempest::params

  include openstacklib::openstackclient

  if $install_from_source {
    $setuptools_pkg = 'python3-setuptools'
    ensure_packages([
      'git',
      $setuptools_pkg,
    ])

    ensure_packages($tempest::params::dev_packages)

    # NOTE(aschultz): Ubuntu setup tools has dropped easy_install since 18.04
    # so we install via package now. Though if we hit this, we can only
    # install "pip". This likely should just be removed though I'm not sure
    # about pip availability for RHEL systems.
    exec { 'install-pip':
      command => 'easy_install pip',
      unless  => "which ${tempest::params::pip_command}",
      path    => ['/bin','/usr/bin','/usr/local/bin'],
      require => Package[$setuptools_pkg],
    }

    exec { 'install-tox':
      command => "${tempest::params::pip_command} install -U tox",
      unless  => 'which tox',
      path    => ['/bin','/usr/bin','/usr/local/bin'],
      require => Exec['install-pip'],
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
      exec { 'setup-venv':
        command => join(["virtualenv -p python3 ${tempest_clone_path}/.venv",
                    "${tempest_clone_path}/.venv/bin/${tempest::params::pip_command} install -U -r requirements.txt"],
                    ' && '),
        cwd     => $tempest_clone_path,
        unless  => "test -d ${tempest_clone_path}/.venv",
        path    => ['/bin','/usr/bin','/usr/local/bin'],
        require => [
          Exec['install-tox'],
          Package[$tempest::params::dev_packages],
        ],
      }
      if $git_clone {
        Vcsrepo<||> -> Exec['setup-venv']
      }
    }

    $tempest_conf = "${tempest_clone_path}/etc/tempest.conf"

    Tempest_config {
      path    => $tempest_conf,
    }
  } else {
    Tempest_config {
      path => $tempest_config_file,
    }
  }

  if ! $install_from_source {
    package { 'tempest':
      ensure => $package_ensure,
      name   => $::tempest::params::package_name,
      tag    => ['openstack', 'tempest-package'],
    }

    $tempest_conf = "${tempest_workspace}/etc/tempest.conf"

    # Create tempest workspace by running tempest init.
    # It will generate etc/tempest.conf, logs and tempest_lock folder
    # in tempest workspace
    exec {'tempest-workspace':
      command     => "tempest init ${tempest_workspace}",
      path        => ['/bin', '/usr/bin'],
      refreshonly => true,
      require     => Package['tempest'],
    }
    Package<| tag == 'tempest-package' |> -> Exec['tempest-workspace']
    Package['tempest'] ~> Exec['tempest-workspace']
    Exec['tempest-workspace'] -> Tempest_config<||>
  }


  tempest_config {
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
    'compute/flavor_ref':                              value => $flavor_ref;
    'compute/flavor_ref_alt':                          value => $flavor_ref_alt;
    # TODO(tkajinam): Remove this after Y release. See bug 1958717
    'compute/image_alt_ssh_user':                      value => $::os_service_default;
    'compute/image_ref':                               value => $image_ref;
    'compute/image_ref_alt':                           value => $image_ref_alt;
    'compute/build_interval':                          value => $compute_build_interval;
    'validation/image_ssh_user':                       value => $image_ssh_user;
    'validation/image_alt_ssh_user':                   value => $image_alt_ssh_user;
    'validation/run_validation':                       value => $run_ssh;
    'validation/ssh_key_type':                         value => $ssh_key_type;
    'identity/admin_role':                             value => $admin_role;
    'identity/alt_password':                           value => $alt_password, secret => true;
    'identity/alt_project_name':                       value => $alt_project_name;
    'identity/alt_username':                           value => $alt_username;
    'identity/password':                               value => $password, secret => true;
    'identity/project_name':                           value => $project_name;
    'identity/uri':                                    value => $identity_uri;
    'identity/uri_v3':                                 value => $identity_uri_v3;
    'identity/username':                               value => $username;
    'identity/auth_version':                           value => $auth_version;
    'identity/ca_certificates_file':                   value => $ca_certificates_file;
    'identity/disable_ssl_certificate_validation':     value => $disable_ssl_validation;
    'identity-feature-enabled/api_v3':                 value => $keystone_v3;
    'image-feature-enabled/api_v1':                    value => pick($glance_v1, $::os_service_default);
    'image-feature-enabled/api_v2':                    value => pick($glance_v2, $::os_service_default);
    'l2gw/l2gw_switch':                                value => $l2gw_switch;
    'network-feature-enabled/api_extensions':          value => $neutron_api_extensions;
    'network/public_network_id':                       value => $public_network_id;
    'network/public_router_id':                        value => $public_router_id;
    'dashboard/login_url':                             value => $login_url;
    'dashboard/dashboard_url':                         value => $dashboard_url;
    'dashboard/disable_ssl_certificate_validation':    value => $disable_dashboard_ssl_validation;
    'database/db_flavor_ref':                          value => $db_flavor_ref;
    'service_available/cinder':                        value => $cinder_available;
    'volume-feature-enabled/backup':                   value => $cinder_backup_available;
    'service_available/glance':                        value => $glance_available;
    'service_available/heat':                          value => $heat_available;
    'service_available/ceilometer':                    value => $ceilometer_available;
    'service_available/aodh':                          value => $aodh_available;
    # TODO(tkajinam): Remove this after Zed release
    'service_available/aodh_plugin':                   value => $::os_service_default;
    'service_available/barbican':                      value => $barbican_available;
    'service_available/bgpvpn':                        value => $neutron_bgpvpn_available;
    'service_available/gnocchi':                       value => $gnocchi_available;
    'service_available/designate':                     value => $designate_available;
    'service_available/horizon':                       value => $horizon_available;
    'service_available/l2gw':                          value => $neutron_l2gw_available;
    'service_available/neutron':                       value => $neutron_available;
    'service_available/mistral':                       value => $mistral_available;
    'service_available/vitrage':                       value => $vitrage_available;
    'service_available/nova':                          value => $nova_available;
    'service_available/murano':                        value => $murano_available;
    'service_available/sahara':                        value => $sahara_available;
    'service_available/swift':                         value => $swift_available;
    'service_available/trove':                         value => $trove_available;
    'service_available/ironic':                        value => $ironic_available;
    'service_available/watcher':                       value => $watcher_available;
    'service_available/zaqar':                         value => $zaqar_available;
    'service_available/ec2api':                        value => $ec2api_available;
    'service_available/octavia':                       value => $octavia_available;
    'enforce_scope/cinder':                            value => $cinder_enforce_scope;
    'enforce_scope/glance':                            value => $glance_enforce_scope;
    'enforce_scope/keystone':                          value => $keystone_enforce_scope;
    'identity-feature-enabled/enforce_scope':          value => $keystone_enforce_scope;
    'enforce_scope/neutron':                           value => $neutron_enforce_scope;
    'enforce_scope/nova':                              value => $nova_enforce_scope;
    'whitebox/db_uri':                                 value => $whitebox_db_uri;
    'cli/cli_dir':                                     value => $cli_dir;
    'scenario/img_file':                               value => $img_file;
    'scenario/img_disk_format':                        value => $img_disk_format;
    'service_broker/run_service_broker_tests':         value => $run_service_broker_tests;
    'dns/nameservers':                                 value => $designate_nameservers;
    'compute-feature-enabled/attach_encrypted_volume': value => $attach_encrypted_volume;
    'compute-feature-enabled/resize':                  value => $resize_available;
    'baremetal/driver':                                value => $baremetal_driver;
    'baremetal/enabled_hardware_types':                value => $baremetal_enabled_hardware_types;
    'load_balancer/member_role':                       value => $load_balancer_member_role;
    'load_balancer/admin_role':                        value => $load_balancer_admin_role;
    'load_balancer/observer_role':                     value => $load_balancer_observer_role;
    'load_balancer/global_observer_role':              value => $load_balancer_global_observer_role;
    'load_balancer/test_with_noop':                    value => $load_balancer_test_with_noop;
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
      package { 'python-telemetry-tests':
        ensure => present,
        name   => $::tempest::params::python_telemetry_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $cinder_available and $::tempest::params::python_cinder_tests {
      package { 'python-cinder-tests':
        ensure => present,
        name   => $::tempest::params::python_cinder_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $glance_available and $::tempest::params::python_glance_tests {
      package { 'python-glance-tests':
        ensure => present,
        name   => $::tempest::params::python_glance_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $heat_available and $::tempest::params::python_heat_tests {
      package { 'python-heat-tests':
        ensure => present,
        name   => $::tempest::params::python_heat_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $ironic_available and $::tempest::params::python_ironic_tests {
      package { 'python-ironic-tests':
        ensure => present,
        name   => $::tempest::params::python_ironic_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $::tempest::params::python_keystone_tests {
      package { 'python-keystone-tests':
        ensure => present,
        name   => $::tempest::params::python_keystone_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $murano_available and $::tempest::params::python_murano_tests {
      package { 'python-murano-tests':
        ensure => present,
        name   => $::tempest::params::python_murano_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $neutron_available and $::tempest::params::python_neutron_tests {
      package { 'python-neutron-tests':
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
      if $neutron_vpnaas_available and $::tempest::params::python_vpnaas_tests {
        package { 'python-neutron-vpnaas-tests':
          ensure => present,
          name   => $::tempest::params::python_vpnaas_tests,
          tag    => ['openstack', 'tempest-package'],
        }
      }
      if $neutron_dr_available and $::tempest::params::python_dr_tests {
        package { 'python-neutron-dynamic-routing-tests':
          ensure => present,
          name   => $::tempest::params::python_dr_tests,
          tag    => ['openstack', 'tempest-package'],
        }
      }
    }
    if $nova_available and $::tempest::params::python_nova_tests {
      package { 'python-nova-tests':
        ensure => present,
        name   => $::tempest::params::python_nova_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $sahara_available and $::tempest::params::python_sahara_tests {
      package { 'python-sahara-tests-tempest':
        ensure => present,
        name   => $::tempest::params::python_sahara_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $swift_available and $::tempest::params::python_swift_tests {
      package { 'python-swift-tests':
        ensure => present,
        name   => $::tempest::params::python_swift_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $trove_available and $::tempest::params::python_trove_tests {
      package { 'python-trove-tests':
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
      package { 'python-zaqar-tests':
        ensure => present,
        name   => $::tempest::params::python_zaqar_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $mistral_available and $::tempest::params::python_mistral_tests {
      package { 'python-mistral-tests':
        ensure => present,
        name   => $::tempest::params::python_mistral_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $vitrage_available and $::tempest::params::python_vitrage_tests {
      package { 'python-vitrage-tests':
        ensure => present,
        name   => $::tempest::params::python_vitrage_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $designate_available and $::tempest::params::python_designate_tests {
      package { 'python-designate-tests':
        ensure => present,
        name   => $::tempest::params::python_designate_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $octavia_available and $::tempest::params::python_octavia_tests {
      package { 'python-octavia-tests':
        ensure => present,
        name   => $::tempest::params::python_octavia_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $ec2api_available and $::tempest::params::python_ec2api_tests {
      package { 'python-ec2-api-tests':
        ensure => present,
        name   => $::tempest::params::python_ec2api_tests,
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

  }

  if ! $flavor_ref and $flavor_name {
    tempest_flavor_id_setter { 'flavor_ref':
      ensure            => present,
      tempest_conf_path => $tempest_conf,
      flavor_name       => $flavor_name,
    }
    Tempest_config<||> -> Tempest_flavor_id_setter['flavor_ref']
    Keystone_user_role<||> -> Tempest_flavor_id_setter['flavor_ref']
  } elsif ($flavor_name and $flavor_ref) {
    fail('flavor_ref and flavor_name are both set: please set only one of them')
  }

  if ! $flavor_ref_alt and $flavor_name_alt {
    tempest_flavor_id_setter { 'flavor_ref_alt':
      ensure            => present,
      tempest_conf_path => $tempest_conf,
      flavor_name       => $flavor_name_alt,
    }
    Tempest_config<||> -> Tempest_flavor_id_setter['flavor_ref_alt']
    Keystone_user_role<||> -> Tempest_flavor_id_setter['flavor_ref_alt']
  } elsif ($flavor_name_alt and $flavor_ref_alt) {
    fail('flavor_ref_alt and flavor_name_alt are both set: please set only one of them')
  }

  if is_service_default($db_flavor_ref) and $db_flavor_name {
    tempest_flavor_id_setter { 'db_flavor_ref':
      ensure            => present,
      tempest_conf_path => $tempest_conf,
      flavor_name       => $db_flavor_name,
    }
    Tempest_config<||> -> Tempest_flavor_id_setter['db_flavor_ref']
    Keystone_user_role<||> -> Tempest_flavor_id_setter['db_flavor_ref']
  } elsif ($db_flavor_name and ! is_service_default($db_flavor_ref)) {
    fail('db_flavor_ref and db_flavor_name are both set: please set only one of them')
  }

  if $configure_images {
    if ! $image_ref and $image_name {
      # If the image id was not provided, look it up via the image name
      # and set the value in the conf file.
      tempest_glance_id_setter { 'image_ref':
        ensure            => present,
        tempest_conf_path => $tempest_conf,
        image_name        => $image_name,
      }
      Tempest_config<||> -> Tempest_glance_id_setter['image_ref']
      Keystone_user_role<||> -> Tempest_glance_id_setter['image_ref']
    } elsif ($image_name and $image_ref) or (! $image_name and ! $image_ref) {
      fail('A value for either image_name or image_ref must be provided.')
    }
    if ! $image_ref_alt and $image_name_alt {
      tempest_glance_id_setter { 'image_ref_alt':
        ensure            => present,
        tempest_conf_path => $tempest_conf,
        image_name        => $image_name_alt,
      }
      Tempest_config<||> -> Tempest_glance_id_setter['image_ref_alt']
      Keystone_user_role<||> -> Tempest_glance_id_setter['image_ref_alt']
    } elsif ($image_name_alt and $image_ref_alt) or (! $image_name_alt and ! $image_ref_alt) {
        fail('A value for either image_name_alt or image_ref_alt must \
be provided.')
    }
  }

  if $neutron_available and $configure_networks {
    if ! $public_network_id and $public_network_name {
      tempest_neutron_net_id_setter { 'public_network_id':
        ensure            => present,
        tempest_conf_path => $tempest_conf,
        network_name      => $public_network_name,
      }
      Tempest_config<||> -> Tempest_neutron_net_id_setter['public_network_id']
      Keystone_user_role<||> -> Tempest_neutron_net_id_setter['public_network_id']
    } elsif ($public_network_name and $public_network_id) or (! $public_network_name and ! $public_network_id) {
      fail('A value for either public_network_id or public_network_name \
  must be provided.')
    }
  }

  if $sahara_available {
    tempest_config {
      'data-processing-feature-enabled/plugins': value => $sahara_plugins,
    }
  }

  if $ec2api_available {
    tempest_config {
      'aws/instance_type':     value => $flavor_ref;
      'aws/instance_type_alt': value => $flavor_ref_alt;
    }
    keystone_user { 'ec2api-tester' :
      ensure  => present,
      enabled => true,
    }
    keystone_user_role { 'ec2api-tester@openstack' :
      ensure => present,
      roles  => $ec2api_tester_roles,
    }
    tempest_ec2_credentials { 'ec2_test_creds':
      ensure            => present,
      tempest_conf_path => $tempest_conf,
      user              => 'ec2api-tester',
      project           => 'openstack',
    }
    Tempest_config<||> -> Tempest_ec2_credentials['ec2_test_creds']
    Keystone_user_role<||> -> Tempest_ec2_credentials['ec2_test_creds']
  }

}
