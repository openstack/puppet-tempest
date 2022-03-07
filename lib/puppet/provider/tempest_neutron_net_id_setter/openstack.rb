require File.join(File.dirname(__FILE__), '..','..','..', 'puppet/provider/tempest')

Puppet::Type.type(:tempest_neutron_net_id_setter).provide(
  :openstack,
  :parent => Puppet::Provider::Tempest
) do

  @credentials = Puppet::Provider::Openstack::CredentialsV3.new

  def file_path
    resource[:tempest_conf_path]
  end

  def exists?
    conf = Puppet::Type::Tempest_config
      .new(:title => resource[:name], :path => file_path)
    entry = Puppet::Type.type(:tempest_config).provider(:ini_setting).new(conf)
    entry.exists?
  end

  def create
    conf = Puppet::Type::Tempest_config
      .new(:title => resource[:name], :value => get_network_id, :path => file_path)
    entry = Puppet::Type.type(:tempest_config).provider(:ini_setting).new(conf)
    entry.create
  end

  def destroy
    conf = Puppet::Type::Tempest_config
      .new(:title => resource[:name], :path => file_path)
    entry = Puppet::Type.type(:tempest_config).provider(:ini_setting).new(conf)
    entry.destroy
  end

  def get_network_id
    if resource[:ensure] == :present or resource[:ensure].nil?
      if @network_id.nil?
        nets = self.class.request('network', 'list', file_path)
        net = nets.detect {|img| img[:name] == resource[:network_name]}
        if net.nil?
          raise(Puppet::Error, "Network #{resource[:network_name]} not found!")
        end
        @network_id = net[:id]
      end
    elsif resource[:ensure] != :absent
      raise(Puppet::Error, "Cannot ensure to #{resource[:ensure]}")
    end
    @network_id
  end
end
