Puppet::Type.newtype(:tempest_flavor_id_setter) do
#
#  tempest_flavor_id_setter { 'flavor_id':
#    tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
#    flavor_name       => $name,
#  }
#

  ensurable

  newparam(:name, :namevar => true) do
    desc 'name of the setting to update'
  end

  newparam(:tempest_conf_path) do
    desc 'path to tempest conf file'
  end

  newparam(:flavor_name) do
    desc 'name of nova flavor'
  end

  autorequire(:nova_flavor) do
    [self[:flavor_name]] if self[:flavor_name]
  end

  autorequire(:package) do
    ['python-openstackclient', 'python3-openstackclient']
  end
end
