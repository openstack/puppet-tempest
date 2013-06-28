
# class for installing and configuring tempest
# This manifest just sets up the basic config for
# tempest. After it is applied, the following still needs
# to be performed.
#  - ensure that openstack::auth is also applied
#  - bash /tmp/test_nova.sh (this will install an image)
#  - capture the image name of the created image with `glance index`
#  - fill in the XXXX in /var/lib/tempest/etc/tempest.conf with the image ID
#  - run `nosetests temptest`
#
# Note that only parameters for which values are provided will be
# managed in tempest.conf.
#
class tempest(
  # Clone config
  #
  $tempest_repo_uri          = "git://github.com/openstack/tempest.git",
  $tempest_clone_path        = '/var/lib/tempest',
  $tempest_clone_owner       = 'root',

  $version_to_test           = 'master',

  # Glance image config
  #
  $image_name                = 'cirros',
  $image_source              = 'https://launchpad.net/cirros/trunk/0.3.0/+download/cirros-0.3.0-x86_64-disk.img',

  # tempest.conf parameters
  #
  $identity_uri              = undef,
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
  # image information
  $image_ref                 = undef,
  $image_ref_alt             = undef,
  $flavor_ref                = undef,
  $flavor_ref_alt            = undef,
  # whitebox
  $whitebox_db_uri           = undef,
  # testing features that are supported
  $resize_available          = undef,
  $change_password_available = undef,

) {

  include 'tempest::params'

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

  vcsrepo { $tempest_clone_path:
    ensure   => 'present',
    source   => $tempest_repo_uri,
    revision => $revision,
    provider => 'git',
    require  => Package['git'],
    user     => $tempest_clone_owner,
  }

  file { "${tempest_clone_path}/jenkins_launch_script.sh":
    source  => 'puppet:///modules/tempest/run_tests.sh',
    mode    => '777',
    require => Vcsrepo[$tempest_clone_path],
  }


  if $version_to_test == 'folsom' {
    file { "${tempest_clone_path}/tempest/openstack":
      purge   => true,
      recurse => true,
      require => Vcsrepo[$tempest_clone_path],
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

  tempest_config {
    'compute/change_password_available': value => $change_password_available;
    'compute/flavor_ref':                value => $flavor_ref;
    'compute/flavor_ref_alt':            value => $flavor_ref_alt;
    'compute/image_ref':                 value => $image_ref;
    'compute/image_ref_alt':             value => $image_ref_alt;
    'compute/resize_available':          value => $resize_available;
    'identity/admin_password':           value => $admin_password;
    'identity/admin_tenant_name':        value => $admin_tenant_name;
    'identity/admin_username':           value => $admin_username;
    'identity/alt_password':             value => $alt_password;
    'identity/alt_tenant_name':          value => $alt_tenant_name;
    'identity/alt_username':             value => $alt_username;
    'identity/password':                 value => $password;
    'identity/tenant_name':              value => $tenant_name;
    'identity/uri':                      value => $identity_uri;
    'identity/username':                 value => $username;
    'whitebox/db_uri':                   value => $whitebox_db_uri;
  }

  keystone_tenant { $tenant_name:
    ensure      => present,
    enabled     => 'True',
    description => 'admin tenant',
  }
  keystone_user { $username:
    ensure      => present,
    enabled     => 'True',
    tenant      => $tenant_name,
    password    => $password,
  }

  keystone_tenant { $alt_tenant_name:
    ensure      => present,
    enabled     => 'True',
    description => 'admin tenant',
  }
  keystone_user { $alt_username:
    ensure      => present,
    enabled     => 'True',
    tenant      => $alt_tenant_name,
    password    => $alt_password,
  }

  # install an image to use for testing...
  glance_image { $image_name:
    ensure           => present,
    is_public        => 'yes',
    container_format => 'bare',
    disk_format      => 'qcow2',
    source           => $image_source,
  }

  # retrieve the name of the glance image
  # and use it to set tempest.conf
  tempest_glance_id_setter { 'image_ref':
    ensure            => present,
    tempest_conf_path => $tempest_conf,
    image_name        => $image_name,
    require => [File[$tempest_conf], Glance_image[$image_name]]
  }
  tempest_glance_id_setter { 'image_ref_alt':
    ensure            => present,
    tempest_conf_path => $tempest_conf,
    image_name        => $image_name,
    require => [File[$tempest_conf], Glance_image[$image_name]]
  }

}
