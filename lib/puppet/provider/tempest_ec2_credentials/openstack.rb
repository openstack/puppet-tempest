require File.join(File.dirname(__FILE__), '..','..','..', 'puppet/provider/tempest')

Puppet::Type.type(:tempest_ec2_credentials).provide(
  :openstack,
  :parent => Puppet::Provider::Tempest
) do

  @credentials = Puppet::Provider::Openstack::CredentialsV3.new

  def exists?
    access_found = false
    secret_found = false
    lines.each do |line|
      l = line.chomp
      if /^aws_access *=/ =~ l
        access_found = true
      end
      if /^aws_secret *=/ =~ l
        secret_found = true
      end
    end
    access_found && secret_found
  end

  def file_path
    resource[:tempest_conf_path]
  end

  def create
    handle_create
  end

  def destroy
    handle_create
  end

  def get_ec2_credentials
    if resource[:ensure] == :present or resource[:ensure].nil?
      if @ec2_credentials.nil?
        @ec2_credentials = self.class.request('ec2 credentials', 'create',
                                      ['--user', "#{resource[:user]}",
                                       '--project', "#{resource[:project]}"],
                                      file_path)
      end
    elsif resource[:ensure] != :absent
      raise(Puppet::Error, "Cannot ensure to #{resource[:ensure]}")
    end
    @ec2_credentials
  end

  def access_line
    "aws_access = #{get_ec2_credentials[:access]}"
  end

  def secret_line
    "aws_secret = #{get_ec2_credentials[:secret]}"
  end

  def conf_regex
    /^\s*aws_(access|secret)\s*=\s*/
  end

  def handle_create()
    file = lines
    file.delete_if { |l| conf_regex.match(l) }
    block_pos = file.find_index { |l| /^\[aws\]/ =~ l }
    if block_pos.nil?
      file += ["[aws]\n", "#{access_line}\n", "#{secret_line}\n"]
    else
      file.insert(block_pos+1, "#{access_line}\n", "#{secret_line}\n")
    end
    File.write(file_path, file.join)
  end

  private
  def lines
    # If this type is ever used with very large files, we should
    #  write this in a different way, using a temp
    #  file; for now assuming that this type is only used on
    #  small-ish config files that can fit into memory without
    #  too much trouble.
    @lines ||= File.readlines(file_path)
  end

end
