class tempest::params {

  if $osfamily == 'redhat' {
    $python_dev  = 'python-devel'
    $libxslt_dev = 'libxslt-devel'
    $libxml2_dev = 'libxml2-devel'
  } elsif $osfamily == 'debian' {
    $libxslt_dev = 'libxslt-dev'
    $python_dev  = 'python-dev'
    $libxml2_dev = 'libxml2-dev'
  }

}
