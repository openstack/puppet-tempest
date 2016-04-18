# class for installing and configuring tempest
#
# The class checks out the tempest repo and sets the basic config.
#
# Note that only parameters for which values are provided will be
# managed in tempest.conf.
#
#  [*install_from_source*]
#   Defaults to true
#  [*git_clone*]
#   Defaults to true
#  [*tempest_config_file*]
#   Defaults to '/var/lib/tempest/etc/tempest.conf'
#  [*tempest_repo_uri*]
#   Defaults to 'git://github.com/openstack/tempest.git'
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
#  [*public_network_name*]
#   Defaults to undef
#  [*identity_uri*]
#   Defaults to undef
#  [*identity_uri_v3*]
#   Defaults to undef
#  [*cli_dir*]
#   Defaults to undef
#  [*lock_path*]
#   Defaults to '/var/lib/tempest'
#  [*debug*]
#   Defaults to false
#  [*use_stderr*]
#   Defaults to true
#  [*use_syslog*]
#   Defaults to false
#  [*log_file*]
#   Defaults to undef
#  [*logging_context_format_string*]
#   Defaults to undef
#  [*username*]
#   Defaults to undef
#  [*password*]
#   Defaults to undef
#  [*tenant_name*]
#   Defaults to undef
#  [*alt_username*]
#   Defaults to undef
#  [*alt_password*]
#   Defaults to undef
#  [*alt_tenant_name*]
#   Defaults to undef
#  [*admin_username*]
#   Defaults to undef
#  [*admin_password*]
#   Defaults to undef
#  [*admin_tenant_name*]
#   Defaults to undef
#  [*admin_role*]
#   Defaults to undef
#  [*admin_domain_name*]
#   Defaults to undef
#  [*image_ref*]
#   Defaults to undef
#  [*image_ref_alt*]
#   Defaults to undef
#  [*image_ssh_user*]
#   Defaults to undef
#  [*image_alt_ssh_user*]
#   Defaults to undef
#  [*flavor_ref*]
#   Defaults to undef
#  [*flavor_ref_alt*]
#   Defaults to undef
#  [*whitebox_db_uri*]
#   Defaults to undef
#  [*resize_available*]
#   Defaults to undef
#  [*change_password_available*]
#   Defaults to undef
#  [*allow_tenant_isolation*]
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
#  [*glance_available*]
#   Defaults to true
#  [*heat_available*]
#   Defaults to false
#  [*ceilometer_available*]
#   Defaults to false
#  [*aodh_available*]
#   Defaults to false
#  [*horizon_available*]
#   Defaults to true
#  [*neutron_available*]
#   Defaults to false
#  [*nova_available*]
#   Defaults to true
#  [*murano_available*]
#   Defaults to false
#  [*zaqar_available*]
#   Defaults to false
#  [*mistral_available*]
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
#  [*keystone_v2*]
#   Defaults to true
#  [*keystone_v3*]
#   Defaults to true
#  [*auth_version*]
#   Defaults to 'v2'
#  [*img_dir*]
#   Defaults to '/var/lib/tempest'
#  [*img_file*]
#   Defaults to 'cirros-0.3.4-x86_64-disk.img'
#  [*login_url*]
#   Defaults to undef
#  [*dashboard_url*]
#   Defaults to undef
#  [*compute_build_interval*]
#   Defaults to undef
#  [*ca_certificates_file*]
#   Defaults to undef
#  [*disable_ssl_validation*]
#   Defaults to undef
#  [*manage_tests_packages*]
#   Defaults to false
#
# DEPREACTED PARAMETERS
#  [*verbose*]
#   Defaults to false
class tempest(
  $install_from_source           = true,
  $git_clone                     = true,
  $tempest_config_file           = '/var/lib/tempest/etc/tempest.conf',

  # Clone config
  #
  $tempest_repo_uri              = 'git://github.com/openstack/tempest.git',
  $tempest_repo_revision         = undef,
  $tempest_clone_path            = '/var/lib/tempest',
  $tempest_clone_owner           = 'root',

  $setup_venv                    = false,

  # Glance image config
  #
  $configure_images              = true,
  $image_name                    = undef,
  $image_name_alt                = undef,

  # Neutron network config
  #
  $configure_networks            = true,
  $public_network_name           = undef,

  # Horizon dashboard config
  $login_url                     = undef,
  $dashboard_url                 = undef,

  # tempest.conf parameters
  #
  $identity_uri                  = undef,
  $identity_uri_v3               = undef,
  $cli_dir                       = undef,
  $lock_path                     = '/var/lib/tempest',
  $debug                         = false,
  $use_stderr                    = true,
  $use_syslog                    = false,
  $log_file                      = undef,
  $logging_context_format_string = undef,
  # non admin user
  $username                      = undef,
  $password                      = undef,
  $tenant_name                   = undef,
  # another non-admin user
  $alt_username                  = undef,
  $alt_password                  = undef,
  $alt_tenant_name               = undef,
  # admin user
  $admin_username                = undef,
  $admin_password                = undef,
  $admin_tenant_name             = undef,
  $admin_role                    = undef,
  $admin_domain_name             = undef,
  # image information
  $image_ref                     = undef,
  $image_ref_alt                 = undef,
  $image_ssh_user                = undef,
  $image_alt_ssh_user            = undef,
  $flavor_ref                    = undef,
  $flavor_ref_alt                = undef,
  $compute_build_interval        = undef,
  # whitebox
  $whitebox_db_uri               = undef,
  # testing features that are     supported
  $resize_available              = undef,
  $change_password_available     = undef,
  $allow_tenant_isolation        = undef,
  # neutron config
  $public_network_id             = undef,
  # Upstream has a bad defaul    t - set it to empty string.
  $public_router_id              = '',
  # Sahara config
  $sahara_plugins                = undef,
  # Service configuration
  $cinder_available              = true,
  $glance_available              = true,
  $heat_available                = false,
  $ceilometer_available          = false,
  $aodh_available                = false,
  $horizon_available             = true,
  $neutron_available             = false,
  $nova_available                = true,
  $murano_available              = false,
  $sahara_available              = false,
  $swift_available               = false,
  $trove_available               = false,
  $ironic_available              = false,
  $zaqar_available               = false,
  $mistral_available             = false,
  $keystone_v2                   = true,
  $keystone_v3                   = true,
  $auth_version                  = 'v2',
  $run_service_broker_tests      = false,
  $ca_certificates_file          = undef,
  $disable_ssl_validation        = undef,
  $manage_tests_packages         = false,
  # scenario options
  $img_dir                       = '/var/lib/tempest',
  $img_file                      = 'cirros-0.3.4-x86_64-disk.img',
  # DEPRECATED PARAMETERS
  $verbose                       = false,
) {

  if $verbose {
    warning('verbose is deprecated and does nothing. Will be remove in a future release.')
  }

  include ::tempest::params

  include ::openstacklib::openstackclient

  if $install_from_source {
    ensure_packages([
      'git',
      'python-setuptools',
    ])

    ensure_packages($tempest::params::dev_packages)

    exec { 'install-pip':
      command => '/usr/bin/easy_install pip',
      unless  => '/usr/bin/which pip',
      require => Package['python-setuptools'],
    }

    exec { 'install-tox':
      command => "${tempest::params::pip_bin_path}/pip install -U tox",
      unless  => '/usr/bin/which tox',
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
        command => "/usr/bin/virtualenv ${tempest_clone_path}/.venv && ${tempest_clone_path}/.venv/bin/pip install -U -r requirements.txt",
        cwd     => $tempest_clone_path,
        unless  => "/usr/bin/test -d ${tempest_clone_path}/.venv",
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

  tempest_config {
    'compute/change_password_available':           value => $change_password_available;
    'compute/flavor_ref':                          value => $flavor_ref;
    'compute/flavor_ref_alt':                      value => $flavor_ref_alt;
    'compute/image_alt_ssh_user':                  value => $image_alt_ssh_user;
    'compute/image_ref':                           value => $image_ref;
    'compute/image_ref_alt':                       value => $image_ref_alt;
    'compute/image_ssh_user':                      value => $image_ssh_user;
    'compute/resize_available':                    value => $resize_available;
    'compute/allow_tenant_isolation':              value => $allow_tenant_isolation;
    'compute/build_interval':                      value => $compute_build_interval;
    'identity/admin_password':                     value => $admin_password, secret => true;
    'identity/admin_tenant_name':                  value => $admin_tenant_name;
    'identity/admin_username':                     value => $admin_username;
    'identity/admin_role':                         value => $admin_role;
    'identity/admin_domain_name':                  value => $admin_domain_name;
    'identity/alt_password':                       value => $alt_password, secret => true;
    'identity/alt_tenant_name':                    value => $alt_tenant_name;
    'identity/alt_username':                       value => $alt_username;
    'identity/password':                           value => $password, secret => true;
    'identity/tenant_name':                        value => $tenant_name;
    'identity/uri':                                value => $identity_uri;
    'identity/uri_v3':                             value => $identity_uri_v3;
    'identity/username':                           value => $username;
    'identity/auth_version':                       value => $auth_version;
    'identity/ca_certificates_file':               value => $ca_certificates_file;
    'identity/disable_ssl_certificate_validation': value => $disable_ssl_validation;
    'identity-feature-enabled/api_v2':             value => $keystone_v2;
    'identity-feature-enabled/api_v3':             value => $keystone_v3;
    'network/public_network_id':                   value => $public_network_id;
    'network/public_router_id':                    value => $public_router_id;
    'dashboard/login_url':                         value => $login_url;
    'dashboard/dashboard_url':                     value => $dashboard_url;
    'service_available/cinder':                    value => $cinder_available;
    'service_available/glance':                    value => $glance_available;
    'service_available/heat':                      value => $heat_available;
    'service_available/ceilometer':                value => $ceilometer_available;
    'service_available/aodh':                      value => $aodh_available;
    'service_available/horizon':                   value => $horizon_available;
    'service_available/neutron':                   value => $neutron_available;
    'service_available/nova':                      value => $nova_available;
    'service_available/murano':                    value => $murano_available;
    'service_available/sahara':                    value => $sahara_available;
    'service_available/swift':                     value => $swift_available;
    'service_available/trove':                     value => $trove_available;
    'service_available/ironic':                    value => $ironic_available;
    'service_available/zaqar':                     value => $zaqar_available;
    'whitebox/db_uri':                             value => $whitebox_db_uri;
    'cli/cli_dir':                                 value => $cli_dir;
    'oslo_concurrency/lock_path':                  value => $lock_path;
    'DEFAULT/debug':                               value => $debug;
    'DEFAULT/use_stderr':                          value => $use_stderr;
    'DEFAULT/use_syslog':                          value => $use_syslog;
    'DEFAULT/log_file':                            value => $log_file;
    'DEFAULT/logging_context_format_string':       value => $logging_context_format_string;
    'scenario/img_dir':                            value => $img_dir;
    'scenario/img_file':                           value => $img_file;
    'service_broker/run_service_broker_tests':     value => $run_service_broker_tests;
  }

  if $manage_tests_packages {
    if $aodh_available and $::tempest::params::python_aodh_tests {
      package { 'python-aodh-tests':
        ensure => present,
        name   => $::tempest::params::python_aodh_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
    if $ceilometer_available and $::tempest::params::python_ceilometer_tests {
      package { 'python-ceilometer-tests':
        ensure => present,
        name   => $::tempest::params::python_ceilometer_tests,
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
      package { 'python-neutron-fwaas-tests':
        ensure => present,
        name   => $::tempest::params::python_fwaas_tests,
        tag    => ['openstack', 'tempest-package'],
      }
      package { 'python-neutron-lbaas-tests':
        ensure => present,
        name   => $::tempest::params::python_lbaas_tests,
        tag    => ['openstack', 'tempest-package'],
      }
      package { 'python-neutron-vpnaas-tests':
        ensure => present,
        name   => $::tempest::params::python_vpnaas_tests,
        tag    => ['openstack', 'tempest-package'],
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
      package { 'python-sahara-tests':
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
      Glance_image<||> -> Tempest_glance_id_setter['image_ref']
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
      Glance_image<||> -> Tempest_glance_id_setter['image_ref_alt']
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
      Neutron_network<||> -> Tempest_neutron_net_id_setter['public_network_id']
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

}
