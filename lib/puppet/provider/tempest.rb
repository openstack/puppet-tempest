require 'puppet/util/inifile'
require 'puppet/provider/openstack'
require 'puppet/provider/openstack/auth'
require 'puppet/provider/openstack/credentials'
class Puppet::Provider::Tempest < Puppet::Provider::Openstack

  extend Puppet::Provider::Openstack::Auth

  def self.tempest_file
    return @tempest_file if @tempest_file
    @tempest_file = Puppet::Util::IniConfig::File.new
    @tempest_file.read(@file_path)
    @tempest_file
  end

  def self.request(service, action, properties=[], file_path)
    @file_path = file_path
    begin
      super(service, action, properties)
    rescue Puppet::Error::OpenstackAuthInputError => error
      tempest_request(service, action, error, properties)
    end
  end

  def self.tempest_request(service, action, error, properties=nil)
    @credentials.username = tempest_credentials['admin_user']
    @credentials.password = tempest_credentials['admin_password']
    @credentials.project_name = tempest_credentials['admin_project_name']
    @credentials.auth_url = tempest_credentials['auth_endpoint']
    raise error unless @credentials.set?
    Puppet::Provider::Openstack.request(service, action, properties, @credentials)
  end

  def self.tempest_credentials
    t = {}
    t['admin_user'] = tempest_file['auth']['admin_username']
    t['admin_password'] = tempest_file['auth']['admin_password']
    t['admin_project_name'] = tempest_file['auth']['admin_project_name']
    t['auth_endpoint'] = tempest_file['identity']['uri']
    return t
  end


end
