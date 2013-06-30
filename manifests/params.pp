class tempest::params {

  if $osfamily == 'redhat' {
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
  } elsif $osfamily == 'debian' {
    # FIXME - This list of packages should be updated to match what is
    # specified for redhat.
    $dev_packages = [
                     'python-dev',
                     'libxslt-dev',
                     'libxml2-dev',
                     'libssl-dev',
                     ]
  }

}
