require 'spec_helper'
require 'puppet'

describe 'Providers' do
  glance_provider_class =
    Puppet::Type.type(:tempest_glance_id_setter).provider(:openstack)
  network_provider_class =
    Puppet::Type.type(:tempest_neutron_net_id_setter).provider(:openstack)

  include PuppetlabsSpec::Files
  let(:tmpfile) { tmpfilename('ini_setting_test') }

  context 'When getting image or network name' do
    before :each do
      File.open(tmpfile, 'w') do |fh|
        fh.write(orig_content)
      end
    end

    def validate_file(expected_content, file = tmpfile)
      expect(File.read(file)).to eq(expected_content)
    end

    let(:glance_params) do
      {
        title:             'image_ref',
        image_name:        'cirros',
        tempest_conf_path: tmpfile
      }
    end

    let(:neutron_params) do
      {
        title:             'public_network_id',
        network_name:      'public',
        tempest_conf_path: tmpfile
      }
    end

    context 'With an existing tempest conf' do
      let(:orig_content) do
        <<-EOS
# This is a comment
[compute]
; This is also a comment
foo=foovalue
bar = barvalue
master = true
[network]
foo= foovalue2
[blah]

EOS
      end

      describe glance_provider_class do
        it 'should put the glance entry in the right place' do
          resource = Puppet::Type::Tempest_glance_id_setter.new(glance_params)
          provider = glance_provider_class.new(resource)
          provider.instance_variable_set(:'@image_id', 'abcdef')
          provider.create
          validate_file(<<-EOS
# This is a comment
[compute]
image_ref = abcdef
; This is also a comment
foo=foovalue
bar = barvalue
master = true
[network]
foo= foovalue2
[blah]

EOS
          )
        end
      end
      describe network_provider_class do
        it 'should put the neutron entry in the right place' do
          resource =
            Puppet::Type::Tempest_neutron_net_id_setter.new(neutron_params)
          provider = network_provider_class.new(resource)
          provider.instance_variable_set(:'@network_id', 'abcdef')
          provider.create
          validate_file(<<-EOS
# This is a comment
[compute]
; This is also a comment
foo=foovalue
bar = barvalue
master = true
[network]
public_network_id = abcdef
foo= foovalue2
[blah]

EOS
          )
        end

        context 'With an empty tempest conf' do
          let(:orig_content) do
        <<-EOS
# This is a comment

EOS
          end

          describe glance_provider_class do
            it 'should put the glance entry in the right place' do
              resource = Puppet::Type::Tempest_glance_id_setter.new(glance_params)
              provider = glance_provider_class.new(resource)
              provider.instance_variable_set(:'@image_id', 'abcdef')
              provider.create
              validate_file(<<-EOS
# This is a comment

[compute]
image_ref = abcdef
EOS
              )
            end
          end
          describe network_provider_class do
            it 'should put the neutron entry in the right place' do
              resource =
                Puppet::Type::Tempest_neutron_net_id_setter.new(neutron_params)
              provider = network_provider_class.new(resource)
              provider.instance_variable_set(:'@network_id', 'abcdef')
              provider.create
              validate_file(<<-EOS
# This is a comment

[network]
public_network_id = abcdef
EOS
              )
            end
          end
        end
      end
    end
  end
end
