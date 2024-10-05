# class: tempest::magnum
#
# Configures Tempest in order to be able to test the Magnum container service.
# Sane defaults are used where possible in order to provide a working testing
# configuration.
#
# === Parameters
#
# [*tempest_config_file*]
#   Defaults to '/var/lib/tempest/etc/tempest.conf'
#
# [*provision_image*]
#   (Optional) If ::tempest::magnum should configure the testing image
#   Defaults to true
#
# [*image_source*]
#   (Optional) If provision_image is true, the location of the image
#   Defaults to 'https://fedorapeople.org/groups/magnum/fedora-atomic-latest.qcow2'
#
# [*image_os_distro*]
#   (Optional) If provision_image is true, the os_distro propery of the image
#   Defaults to fedora-atomic-latest
#
# [*image_name*]
#   (Optional) The name of the image to be used for ClusterTemplate
#   Defaults to 'fedora-atomic-latest'
#
# [*provision_flavors*]
#   (Optional) If ::tempest::magnum should configure the testing flavors
#   Defaults to true
#
# [*flavor_id*]
#   (Optional) The name of the flavor to be used for ClusterTemplate
#   Defaults to 's1.magnum'
#
# [*master_flavor_id*]
#   (Optional) The name of the master flavor to be used for ClusterTemplate
#   Defaults to 'm1.magnum'
#
# [*provision_keypair*]
#   (Optional) If ::tempest::magnum should configure the testing keypair
#   Defaults to false (not yet supported, will be true when implemented)
#
# [*keypair_id*]
#   (Optional) The keypair_id parameter used in Magnum tempest configuration
#   Defaults to 'default'
#
# [*nic_id*]
#   (Optional) The nic_id parameter used in Magnum tempest configuration
#   Defaults to 'public'
#
# [*magnum_url*]
#   (Optional) Bypass URL for Magnum to skip service catalog lookup
#   Defaults to undef
#
# [*copy_logs*]
#   (Optional) Whether to copy nova server logs on failure
#   Defaults to true
#
# [*dns_nameserver*]
#   (Optional) DNS nameserver to use for ClusterTemplate
#   Defaults to '8.8.8.8'
#
# [*catalog_type*]
#   (Optional) Catalog type of the coe service
#   Defaults to $facts['os_service_default']
#
# [*manage_tests_packages*]
#   (Optional) Manage the plugin package
#   Defaults to true
#
class tempest::magnum (
  Stdlib::Absolutepath $tempest_config_file = '/var/lib/tempest/etc/tempest.conf',
  Boolean $provision_image                  = true,
  String[1] $image_source                   = 'https://fedorapeople.org/groups/magnum/fedora-atomic-latest.qcow2',
  String[1] $image_name                     = 'fedora-atomic-latest',
  String[1] $image_os_distro                = 'fedora-atomic',
  Boolean $provision_flavors                = true,
  String[1] $flavor_id                      = 's1.magnum',
  String[1] $master_flavor_id               = 'm1.magnum',
  Boolean $provision_keypair                = false,
  $keypair_id                               = 'default',
  $nic_id                                   = 'public',
  $magnum_url                               = undef,
  $copy_logs                                = true,
  $dns_nameserver                           = '8.8.8.8',
  $catalog_type                             = $facts['os_service_default'],
  Boolean $manage_tests_packages            = true,
) {
  include tempest::params

  if $provision_image {
    $image_properties = { 'os_distro' => $image_os_distro }
    glance_image { $image_name:
      ensure           => present,
      container_format => 'bare',
      disk_format      => 'qcow2',
      is_public        => 'yes',
      source           => $image_source,
      properties       => $image_properties,
    }
  }

  if $provision_flavors {
    nova_flavor { $flavor_id:
      ensure => present,
      id     => '200',
      ram    => '512',
      disk   => '10',
      vcpus  => '1',
    }

    nova_flavor { $master_flavor_id:
      ensure => present,
      id     => '100',
      ram    => '1024',
      disk   => '10',
      vcpus  => '1',
    }
  }

  if $manage_tests_packages {
    if $::tempest::params::python_magnum_tests {
      package { 'python-magnum-tests':
        ensure => present,
        name   => $::tempest::params::python_magnum_tests,
        tag    => ['openstack', 'tempest-package'],
      }
    }
  }

  Tempest_config {
    path    => $tempest_config_file,
  }

  tempest_config {
    'magnum/image_id':         value => $image_name;
    'magnum/nic_id':           value => $nic_id;
    'magnum/keypair_id':       value => $keypair_id;
    'magnum/flavor_id':        value => $flavor_id;
    'magnum/master_flavor_id': value => $master_flavor_id;
    'magnum/magnum_url':       value => $magnum_url;
    'magnum/copy_logs':        value => $copy_logs;
    'magnum/dns_nameserver':   value => $dns_nameserver;
    'magnum/catalog_type':     value => $catalog_type;
  }
}
