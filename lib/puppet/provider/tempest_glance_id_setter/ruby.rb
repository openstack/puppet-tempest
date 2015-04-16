Puppet::Type.type(:tempest_glance_id_setter).provide(:ruby) do

  # almost entirely lifted from stdlib's file_line

  def exists?
    lines.find do |line|
      should_line.chomp == line.chomp
    end
  end

  def create
    handle_create_with_match
  end

  def get_image_id
    @image_id ||= Puppet::Resource.indirection.find("Glance_image/#{resource[:image_name]}")[:id]
    @image_id if @image_id != :absent
  end

  def should_line
    "#{resource[:name]} = #{get_image_id}"
  end

  def match
    /^\s*#{resource[:name]}\s*=\s*/
  end

  def handle_create_with_match()
    regex = match
    match_count = lines.select { |l| regex.match(l) }.count

    file = lines
    case match_count
    when 1
      File.open(resource[:tempest_conf_path], 'w') do |fh|
        lines.each do |l|
          fh.puts(regex.match(l) ? "#{should_line}" : l)
        end
      end
    when 0
      block_pos = lines.find_index { |l| /^\[compute\]/ =~ l }
      if block_pos.nil?
        file += ["[compute]\n", "#{should_line}\n"]
      else
        file.insert(block_pos+1, "#{should_line}\n")
      end
      File.write(resource[:tempest_conf_path], file.join)
    else                        # cannot be negative.
      raise Puppet::Error, "More than one line in file \
'#{resource[:tempest_conf_path]}' matches pattern '#{regex}'"
    end
  end

  private
  def lines
    # If this type is ever used with very large files, we should
    #  write this in a different way, using a temp
    #  file; for now assuming that this type is only used on
    #  small-ish config files that can fit into memory without
    #  too much trouble.
    @lines ||= File.readlines(resource[:tempest_conf_path])
  end

end
