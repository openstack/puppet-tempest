#
class tempest::params {
  include ::openstacklib::defaults
  $pyvers = $::openstacklib::defaults::pyvers

  $pip_command = "pip${pyvers}"
  case $::osfamily {
    'RedHat': {
      $dev_packages = [
        "python${pyvers}-devel",
        'libxslt-devel',
        'libxml2-devel',
        'openssl-devel',
        'libffi-devel',
        'patch',
        'gcc'
      ]
      $python_telemetry_tests  = "python${pyvers}-telemetry-tests-tempest"
      $python_cinder_tests     = "python${pyvers}-cinder-tests-tempest"
      $python_designate_tests  = "python${pyvers}-designate-tests-tempest"
      $python_glance_tests     = "python${pyvers}-glance-tests"
      $python_heat_tests       = "python${pyvers}-heat-tests-tempest"
      $python_horizon_tests    = "python${pyvers}-horizon-tests-tempest"
      $python_ironic_tests     = "python${pyvers}-ironic-tests-tempest"
      $python_keystone_tests   = "python${pyvers}-keystone-tests"
      $python_magnum_tests     = "python${pyvers}-magnum-tests-tempest"
      $python_mistral_tests    = "python${pyvers}-mistral-tests-tempest"
      $python_vitrage_tests    = "python${pyvers}-vitrage-tests-tempest"
      $python_murano_tests     = "python${pyvers}-murano-tests-tempest"
      $python_neutron_tests    = "python${pyvers}-neutron-tests-tempest"
      $python_fwaas_tests      = "python${pyvers}-neutron-fwaas-tests"
      $python_l2gw_tests       = "python${pyvers}-networking-l2gw-tests-tempest"
      $python_vpnaas_tests     = "python${pyvers}-neutron-vpnaas-tests"
      $python_dr_tests         = "python${pyvers}-neutron-dynamic-routing-tests"
      $python_nova_tests       = "python${pyvers}-nova-tests"
      $python_sahara_tests     = "python${pyvers}-sahara-tests-tempest"
      $python_swift_tests      = 'python-swift-tests'
      $python_trove_tests      = "python${pyvers}-trove-tests-tempest"
      $python_watcher_tests    = "python${pyvers}-watcher-tests-tempest"
      $python_zaqar_tests      = "python${pyvers}-zaqar-tests-tempest"
      $python_congress_tests   = "python${pyvers}-congress-tests-tempest"
      $python_octavia_tests    = "python${pyvers}-octavia-tests-tempest"
      $python_ec2api_tests     = "python${pyvers}-ec2api-tests-tempest"
      $python_barbican_tests   = "python${pyvers}-barbican-tests-tempest"
      $package_name            = 'openstack-tempest'
    }
    'Debian': {
      $dev_packages = [
        "python${pyvers}-dev",
        'libxslt1-dev',
        'libxml2-dev',
        'libssl-dev',
        'libffi-dev',
        'patch',
        'gcc',
        "python${pyvers}-virtualenv",
        "python${pyvers}-pip",
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

