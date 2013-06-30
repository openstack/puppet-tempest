Puppet::Type.newtype(:tempest_quantum_net_id_setter) do

  ensurable

  newparam(:name, :namevar => true) do
    desc 'The name of the setting to update.'
  end

  newparam(:tempest_conf_path) do
    desc 'The path to tempest conf file.'
  end

  newparam(:network_name) do
    desc 'The name of the quantum network.'
  end

end
