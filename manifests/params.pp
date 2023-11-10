#
class tempest::params {
  include openstacklib::defaults

  $pip_command = 'pip3'
  case $facts['os']['family'] {
    'RedHat': {
      $dev_packages = [
        'python3-devel',
        'libxslt-devel',
        'libxml2-devel',
        'openssl-devel',
        'libffi-devel',
        'patch',
        'gcc'
      ]
      $python_telemetry_tests  = 'python3-telemetry-tests-tempest'
      $python_cinder_tests     = 'python3-cinder-tests-tempest'
      $python_designate_tests  = 'python3-designate-tests-tempest'
      $python_glance_tests     = 'python3-glance-tests-tempest'
      $python_heat_tests       = 'python3-heat-tests-tempest'
      $python_ironic_tests     = 'python3-ironic-tests-tempest'
      $python_keystone_tests   = 'python3-keystone-tests-tempest'
      $python_magnum_tests     = 'python3-magnum-tests-tempest'
      $python_mistral_tests    = 'python3-mistral-tests-tempest'
      $python_vitrage_tests    = 'python3-vitrage-tests-tempest'
      $python_murano_tests     = 'python3-murano-tests-tempest'
      $python_neutron_tests    = 'python3-neutron-tests-tempest'
      $python_l2gw_tests       = 'python3-networking-l2gw-tests-tempest'
      $python_sahara_tests     = 'python3-sahara-tests-tempest'
      $python_trove_tests      = 'python3-trove-tests-tempest'
      $python_watcher_tests    = 'python3-watcher-tests-tempest'
      $python_zaqar_tests      = 'python3-zaqar-tests-tempest'
      $python_octavia_tests    = 'python3-octavia-tests-tempest'
      $python_ec2api_tests     = 'python3-ec2api-tests-tempest'
      $python_barbican_tests   = 'python3-barbican-tests-tempest'
      $python_manila_tests     = 'python3-manila-tests-tempest'
      $package_name            = 'openstack-tempest'
      $pip_package_name        = $facts['os']['name'] ? {
        'RedHat' => undef,
        default  => 'python3-pip'
      }
    }
    'Debian': {
      $dev_packages = [
        'python3-dev',
        'libxslt1-dev',
        'libxml2-dev',
        'libssl-dev',
        'libffi-dev',
        'patch',
        'gcc',
        'python3-virtualenv',
      ]
      if $facts['os']['name'] == 'Debian' {
        $python_telemetry_tests  = 'telemetry-tempest-plugin'
        $python_cinder_tests     = 'cinder-tempest-plugin'
        $python_designate_tests  = 'designate-tempest-plugin'
        $python_glance_tests     = 'glance-tempest-plugin'
        $python_heat_tests       = 'heat-tempest-plugin'
        $python_ironic_tests     = 'ironic-tempest-plugin'
        $python_keystone_tests   = 'keystone-tempest-plugin'
        $python_magnum_tests     = 'magnum-tempest-plugin'
        $python_mistral_tests    = 'mistral-tempest-plugin'
        $python_vitrage_tests    = 'vitrage-tempest-plugin'
        $python_murano_tests     = 'murano-tempest-plugin'
        $python_neutron_tests    = 'neutron-tempest-plugin'
        $python_l2gw_tests       = false
        $python_sahara_tests     = false
        $python_trove_tests      = 'trove-tempest-plugin'
        $python_watcher_tests    = 'watcher-tempest-plugin'
        $python_zaqar_tests      = 'zaqar-tempest-plugin'
        $python_octavia_tests    = 'octavia-tempest-plugin'
        $python_ec2api_tests     = false
        $python_barbican_tests   = 'barbican-tempest-plugin'
        $python_manila_tests     = 'manila-tempest-plugin'
        $package_name            = 'tempest'
      }else{
        $python_telemetry_tests  = false
        $python_cinder_tests     = false
        $python_designate_tests  = false
        $python_glance_tests     = false
        $python_heat_tests       = false
        $python_ironic_tests     = false
        $python_keystone_tests   = false
        $python_magnum_tests     = false
        $python_mistral_tests    = false
        $python_vitrage_tests    = false
        $python_murano_tests     = false
        $python_neutron_tests    = false
        $python_l2gw_tests       = false
        $python_sahara_tests     = false
        $python_trove_tests      = false
        $python_watcher_tests    = false
        $python_zaqar_tests      = false
        $python_octavia_tests    = false
        $python_ec2api_tests     = false
        $python_barbican_tests   = false
        $python_manila_tests     = false
        $package_name            = 'tempest'
      }
      $pip_package_name          = 'python3-pip'
    }
    default: {
      fail("Unsupported osfamily: ${facts['os']['family']}")
    }
  }
}

