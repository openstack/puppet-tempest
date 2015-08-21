Puppet::Type.type(:tempest_config).provide(
  :ini_setting,
  :parent => Puppet::Type.type(:openstack_config).provider(:ini_setting)
) do

  def file_path
    resource[:path]
  end

end
