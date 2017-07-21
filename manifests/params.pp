#
class tempest::params {
  include ::openstacklib::defaults
  case $::osfamily {
    'RedHat': {
      $dev_packages = [
        'python-devel',
        'libxslt-devel',
        'libxml2-devel',
        'openssl-devel',
        'libffi-devel',
        'patch',
        'gcc'
      ]
      $python_aodh_tests       = 'python-aodh-tests'
      $python_bgpvpn_tests     = 'python-networking-bgpvpn-tests'
      $python_ceilometer_tests = 'python-ceilometer-tests'
      $python_cinder_tests     = 'python-cinder-tests'
      $python_designate_tests  = 'python-designate-tests-tempest'
      $python_glance_tests     = 'python-glance-tests'
      $python_gnocchi_tests    = 'python-gnocchi-tests'
      $python_heat_tests       = 'python-heat-tests'
      $python_horizon_tests    = 'python-horizon-tests-tempest'
      $python_ironic_tests     = 'python-ironic-tests'
      $python_keystone_tests   = 'python-keystone-tests'
      $python_magnum_tests     = 'python-magnum-tests'
      $python_mistral_tests    = 'python-mistral-tests'
      $python_vitrage_tests    = 'python-vitrage-tests'
      $python_murano_tests     = 'python-murano-tests'
      $python_neutron_tests    = 'python-neutron-tests'
      $python_fwaas_tests      = 'python-neutron-fwaas-tests'
      $python_lbaas_tests      = 'python-neutron-lbaas-tests'
      $python_l2gw_tests       = 'python-networking-l2gw-tests-tempest'
      $python_vpnaas_tests     = 'python-neutron-vpnaas-tests'
      $python_nova_tests       = 'python-nova-tests'
      $python_sahara_tests     = 'python-sahara-tests-tempest'
      $python_swift_tests      = 'python-swift-tests'
      $python_trove_tests      = 'python-trove-tests'
      $python_watcher_tests    = 'python-watcher-tests-tempest'
      $python_zaqar_tests      = 'python-zaqar-tests'
      $python_congress_tests   = 'python-congress-tests'
      $python_panko_tests      = 'python-panko-tests'
      $python_octavia_tests    = 'python-octavia-tests'
      $python_ec2api_tests     = 'python-ec2-api-tests'
      $python_barbican_tests   = 'python-barbican-tests-tempest'
      $package_name            = 'openstack-tempest'
    }
    'Debian': {
      $dev_packages = [
        'python-dev',
        'libxslt1-dev',
        'libxml2-dev',
        'libssl-dev',
        'libffi-dev',
        'patch',
        'gcc',
        'python-virtualenv',
      ]
      $python_aodh_tests       = false
      $python_bgpvpn_tests     = false
      $python_ceilometer_tests = false
      $python_cinder_tests     = false
      $python_designate_tests  = false
      $python_glance_tests     = false
      $python_gnocchi_tests    = false
      $python_heat_tests       = false
      $python_horizon_tests    = false
      $python_ironic_tests     = false
      $python_keystone_tests   = false
      $python_l2gw_tests       = false
      $python_magnum_tests     = false
      $python_mistral_tests    = false
      $python_vitrage_tests    = false
      $python_murano_tests     = false
      $python_neutron_tests    = false
      $python_nova_tests       = false
      $python_sahara_tests     = false
      $python_swift_tests      = false
      $python_trove_tests      = false
      $python_watcher_tests    = false
      $python_zaqar_tests      = false
      $python_congress_tests   = false
      $python_panko_tests      = false
      $python_octavia_tests    = false
      $python_ec2api_tests     = false
      $python_barbican_tests   = false
      $package_name            = 'tempest'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem: ${::operatingsystem}, \
module ${module_name} only support osfamily RedHat and Debian")
    }
  }
}

