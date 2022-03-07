require File.join(File.dirname(__FILE__), '..','..','..', 'puppet/provider/tempest')

Puppet::Type.type(:tempest_flavor_id_setter).provide(
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
      .new(:title => resource[:name], :value => get_flavor_id, :path => file_path)
    entry = Puppet::Type.type(:tempest_config).provider(:ini_setting).new(conf)
    entry.create
  end

  def destroy
    conf = Puppet::Type::Tempest_config
      .new(:title => resource[:name], :path => file_path)
    entry = Puppet::Type.type(:tempest_config).provider(:ini_setting).new(conf)
    entry.destroy
  end

  def get_flavor_id
    if resource[:ensure] == :present or resource[:ensure].nil?
      if @flavor_id.nil?
        flavors = self.class.request('flavor', 'list', file_path)
        flavor = flavors.detect {|flavor| flavor[:name] == resource[:flavor_name]}
        if flavor.nil?
          raise(Puppet::Error, "Flavor #{resource[:flavor_name]} not found!")
        end
        @flavor_id = flavor[:id]
      end
    elsif resource[:ensure] != :absent
      raise(Puppet::Error, "Cannot ensure to #{resource[:ensure]}")
    end
    @flavor_id
  end
end
