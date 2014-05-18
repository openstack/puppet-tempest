#
class tempest::params {
  case $::osfamily {
    'RedHat': {
      $pip_bin_path = '/usr/bin'
      $dev_packages = [
        'python-devel',
        'libxslt-devel',
        'libxml2-devel',
        'openssl-devel',
        'libffi-devel',
        'patch',
        'gcc',
      ]
    }
    'Debian': {
      $pip_bin_path = '/usr/local/bin'
      $dev_packages = [
        'python-dev',
        'libxslt1-dev',
        'libxml2-dev',
        'libssl-dev',
        'libffi-dev',
        'patch',
        'gcc',
      ]
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat and Debian")
    }
  }
}

