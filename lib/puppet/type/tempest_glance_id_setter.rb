Puppet::Type.newtype(:tempest_glance_id_setter) do
#
#  tempest_glance_id_setter { 'image_id':
#    tempest_conf_path => '/var/lib/tempest/etc/tempest.conf',
#    image_name        => $name,
#  }
#

  ensurable

  newparam(:name, :namevar => true) do
    desc 'name of the setting to update'
  end

  newparam(:tempest_conf_path) do
    desc 'path to tempest conf file'
  end

  newparam(:image_name) do
    desc 'name of glance image'
  end

  autorequire(:package) do
    ['python-openstackclient', 'python3-openstackclient']
  end
end
