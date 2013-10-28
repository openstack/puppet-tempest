#
class tempest::params {
  case $::osfamily {
    'RedHat': {
      $pip_bin_path = '/usr/bin'
      if $::operatingsystem == 'Fedora' and $::operatingsystemrelease >= 19 {
        $pkg_set1 = [ 'mariadb-devel' ]
      } else {
        $pkg_set1 = [ 'mysql-devel' ]
      }
      $pkg_set2 = [
        'python-devel',
        'libxslt-devel',
        'libxml2-devel',
        'openssl-devel',
        'postgresql-devel',
        'patch',
        'gcc',
      ]
      $dev_packages = concat( $pkg_set1, $pkg_set2 )
    }
    'Debian': {
      $pip_bin_path = '/usr/local/bin'
      $dev_packages = [
        'libmysqlclient-dev',
        'libpq-dev',
        'python-dev',
        'libxslt1-dev',
        'libxml2-dev',
        'libssl-dev',
        'patch',
        'gcc',
      ]
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, module ${module_name} only support osfamily RedHat and Debian")
    }
  }
}

