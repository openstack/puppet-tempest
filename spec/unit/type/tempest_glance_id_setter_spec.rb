require 'puppet'
require 'puppet/type/tempest_glance_id_setter'

describe 'Puppet::Type.type(:tempest_glance_id_setter)' do
  it 'should require a name' do
    expect {
      Puppet::Type.type(:tempest_glance_id_setter).new({})
    }.to raise_error(Puppet::Error, 'Title or name must be provided')
  end

  before :each do
    @tempest_glance_id_setter = Puppet::Type.type(:tempest_glance_id_setter).new(
      :name              => 'foo',
      :tempest_conf_path => '/tmp/tempest.conf',
      :image_name        => 'image')

  end

  it 'should accept valid ensure values' do
    @tempest_glance_id_setter[:ensure] = :present
    expect(@tempest_glance_id_setter[:ensure]).to eq(:present)
    @tempest_glance_id_setter[:ensure] = :absent
    expect(@tempest_glance_id_setter[:ensure]).to eq(:absent)
  end

  it 'should not accept invalid ensure values' do
    expect {
      @tempest_glance_id_setter[:ensure] = :installed
    }.to raise_error(Puppet::Error, /Invalid value/)
  end
end
