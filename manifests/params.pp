#
class tempest::params {

  case $::osfamily {
    'RedHat': {
      $dev_packages = [
        'python-devel',
        'libxslt-devel',
        'libxml2-devel',
        'openssl-devel',
        'mysql-devel',
        'postgresql-devel',
        'patch',
        'gcc',
      ]
    }
    'Debian': {
      # FIXME - This list of packages should be updated to match what is
      # specified for redhat.
      $dev_packages = [
        'python-dev',
        'libxslt-dev',
        'libxml2-dev',
        'libssl-dev',
      ]
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat and Debian")
    }
  }
}
