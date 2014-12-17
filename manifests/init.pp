# class for installing and configuring tempest
#
# The class checks out the tempest repo and sets the basic config.
#
# Note that only parameters for which values are provided will be
# managed in tempest.conf.
#
class tempest(
  $install_from_source       = true,
  $tempest_config_file       = '/var/lib/tempest/etc/tempest.conf',

  # Clone config
  #
  $tempest_repo_uri          = 'git://github.com/openstack/tempest.git',
  $tempest_repo_revision     = undef,
  $tempest_clone_path        = '/var/lib/tempest',
  $tempest_clone_owner       = 'root',

  $setup_venv                = false,

  # Glance image config
  #
  $configure_images          = true,
  $image_name                = undef,
  $image_name_alt            = undef,

  # Neutron network config
  #
  $configure_networks        = true,
  $public_network_name       = undef,

  # tempest.conf parameters
  #
  $identity_uri              = undef,
  $cli_dir                   = undef,
  # non admin user
  $username                  = undef,
  $password                  = undef,
  $tenant_name               = undef,
  # another non-admin user
  $alt_username              = undef,
  $alt_password              = undef,
  $alt_tenant_name           = undef,
  # admin user
  $admin_username            = undef,
  $admin_password            = undef,
  $admin_tenant_name         = undef,
  $admin_role                = undef,
  # image information
  $image_ref                 = undef,
  $image_ref_alt             = undef,
  $image_ssh_user            = undef,
  $image_alt_ssh_user        = undef,
  $flavor_ref                = undef,
  $flavor_ref_alt            = undef,
  # whitebox
  $whitebox_db_uri           = undef,
  # testing features that are supported
  $resize_available          = undef,
  $change_password_available = undef,
  $allow_tenant_isolation    = undef,
  # neutron config
  $public_network_id         = undef,
  # Upstream has a bad default - set it to empty string.
  $public_router_id          = '',
  # Service configuration
  $cinder_available          = true,
  $glance_available          = true,
  $heat_available            = false,
  $ceilometer_available      = false,
  $horizon_available         = true,
  $neutron_available         = false,
  $nova_available            = true,
  $swift_available           = false
) {

  include 'tempest::params'

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

    vcsrepo { $tempest_clone_path:
      ensure   => 'present',
      source   => $tempest_repo_uri,
      revision => $tempest_repo_revision,
      provider => 'git',
      require  => Package['git'],
      user     => $tempest_clone_owner,
    }

    if $setup_venv {
      # virtualenv will be installed along with tox
      exec { 'setup-venv':
        command => "/usr/bin/python ${tempest_clone_path}/tools/install_venv.py",
        cwd     => $tempest_clone_path,
        unless  => "/usr/bin/test -d ${tempest_clone_path}/.venv",
        require => [
          Vcsrepo[$tempest_clone_path],
          Exec['install-tox'],
          Package[$tempest::params::dev_packages],
        ],
      }
    }

    $tempest_conf = "${tempest_clone_path}/etc/tempest.conf"

    file { $tempest_conf:
      replace => false,
      source  => "${tempest_conf}.sample",
      require => Vcsrepo[$tempest_clone_path],
      owner   => $tempest_clone_owner,
    }

    Tempest_config {
      path    => $tempest_conf,
      require => File[$tempest_conf],
    }
  } else {
    Tempest_config {
      path => $tempest_config_file,
    }
  }

  tempest_config {
    'compute/change_password_available': value => $change_password_available;
    'compute/flavor_ref':                value => $flavor_ref;
    'compute/flavor_ref_alt':            value => $flavor_ref_alt;
    'compute/image_alt_ssh_user':        value => $image_alt_ssh_user;
    'compute/image_ref':                 value => $image_ref;
    'compute/image_ref_alt':             value => $image_ref_alt;
    'compute/image_ssh_user':            value => $image_ssh_user;
    'compute/resize_available':          value => $resize_available;
    'compute/allow_tenant_isolation':    value => $allow_tenant_isolation;
    'identity/admin_password':           value => $admin_password, secret => true;
    'identity/admin_tenant_name':        value => $admin_tenant_name;
    'identity/admin_username':           value => $admin_username;
    'identity/admin_role':               value => $admin_role;
    'identity/alt_password':             value => $alt_password, secret => true;
    'identity/alt_tenant_name':          value => $alt_tenant_name;
    'identity/alt_username':             value => $alt_username;
    'identity/password':                 value => $password, secret => true;
    'identity/tenant_name':              value => $tenant_name;
    'identity/uri':                      value => $identity_uri;
    'identity/username':                 value => $username;
    'network/public_network_id':         value => $public_network_id;
    'network/public_router_id':          value => $public_router_id;
    'service_available/cinder':          value => $cinder_available;
    'service_available/glance':          value => $glance_available;
    'service_available/heat':            value => $heat_available;
    'service_available/ceilometer':      value => $ceilometer_available;
    'service_available/horizon':         value => $horizon_available;
    'service_available/neutron':         value => $neutron_available;
    'service_available/nova':            value => $nova_available;
    'service_available/swift':           value => $swift_available;
    'whitebox/db_uri':                   value => $whitebox_db_uri;
    'cli/cli_dir':                       value => $cli_dir;
  }

  if $configure_images {
    if ! $image_ref and $image_name {
      # If the image id was not provided, look it up via the image name
      # and set the value in the conf file.
      tempest_glance_id_setter { 'image_ref':
        ensure            => present,
        tempest_conf_path => $tempest_conf,
        image_name        => $image_name,
        require           => File[$tempest_conf],
      }
    } elsif ($image_name and $image_ref) or (! $image_name and ! $image_ref) {
      fail('A value for either image_name or image_ref must be provided.')
    }
    if ! $image_ref_alt and $image_name_alt {
      tempest_glance_id_setter { 'image_ref_alt':
        ensure            => present,
        tempest_conf_path => $tempest_conf,
        image_name        => $image_name_alt,
        require           => File[$tempest_conf],
      }
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
        require           => File[$tempest_conf],
      }
    } elsif ($public_network_name and $public_network_id) or (! $public_network_name and ! $public_network_id) {
      fail('A value for either public_network_id or public_network_name \
  must be provided.')
    }
  }

}
