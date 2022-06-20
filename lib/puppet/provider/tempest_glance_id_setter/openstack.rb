require File.join(File.dirname(__FILE__), '..','..','..', 'puppet/provider/tempest')

Puppet::Type.type(:tempest_glance_id_setter).provide(
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
      .new(:title => resource[:name], :value => get_image_id, :path => file_path)
    entry = Puppet::Type.type(:tempest_config).provider(:ini_setting).new(conf)
    entry.create
  end

  def destroy
    conf = Puppet::Type::Tempest_config
      .new(:title => resource[:name], :path => file_path)
    entry = Puppet::Type.type(:tempest_config).provider(:ini_setting).new(conf)
    entry.destroy
  end

  def get_image_id
    if resource[:ensure] == :present or resource[:ensure].nil?
      if @image_id.nil?
        images = self.class.request('image', 'list', file_path)
        img = images.detect {|img| img[:name] == resource[:image_name]}
        if img.nil?
          raise(Puppet::Error, "Image #{resource[:image_name]} not found!")
        end
        @image_id = img[:id]
      end
    elsif resource[:ensure] != :absent
      raise(Puppet::Error, "Cannot ensure to #{resource[:ensure]}")
    end
    @image_id
  end
end
