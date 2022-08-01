Puppet::Type.newtype(:tempest_neutron_net_id_setter) do

  ensurable

  newparam(:name, :namevar => true) do
    desc 'The name of the setting to update.'
    munge do |value|
      if value.include? '/'
        value
      else
        # This is to keep the backword compatibility
        "network/#{value}"
      end
    end
  end

  newparam(:tempest_conf_path) do
    desc 'The path to tempest conf file.'
  end

  newparam(:network_name) do
    desc 'The name of the neutron network.'
  end

  autorequire(:neutron_network) do
    [self[:network_name]] if self[:network_name]
  end

  autorequire(:package) do
    ['python-openstackclient', 'python3-openstackclient']
  end
end
