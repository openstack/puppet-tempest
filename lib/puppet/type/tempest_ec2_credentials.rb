Puppet::Type.newtype(:tempest_ec2_credentials) do

  ensurable

  newparam(:name, :namevar => true) do
    desc 'Name of the credentials.'
  end

  newparam(:user) do
    desc 'Name of the user to create credentials for.'
  end

  newparam(:project) do
    desc 'Name of the project to create credentials in.'
  end

  newparam(:tempest_conf_path) do
    desc 'The path to tempest conf file.'
  end

  autorequire(:package) do
    ['python-openstackclient']
  end
end
