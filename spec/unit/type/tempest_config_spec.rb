require 'puppet'
require 'puppet/type/tempest_config'

describe 'Puppet::Type.type(:tempest_config)' do
  before :each do
    @tempest_config = Puppet::Type.type(:tempest_config).new(:name => 'DEFAULT/foo', :value => 'bar')
  end

  it 'should require a name' do
    expect {
      Puppet::Type.type(:tempest_config).new({})
    }.to raise_error(Puppet::Error, 'Title or name must be provided')
  end

  it 'should not expect a name with whitespace' do
    expect {
      Puppet::Type.type(:tempest_config).new(:name => 'f oo')
    }.to raise_error(Puppet::Error, /Invalid value "f oo"/)
  end

  it 'should fail when there is no section' do
    expect {
      Puppet::Type.type(:tempest_config).new(:name => 'foo')
    }.to raise_error(Puppet::Error, /Invalid value "foo"/)
  end

  it 'should not require a value when ensure is absent' do
    Puppet::Type.type(:tempest_config).new(:name => 'DEFAULT/foo', :ensure => :absent)
  end

  it 'should accept a valid value' do
    @tempest_config[:value] = 'bar'
    expect(@tempest_config[:value]).to eq('bar')
  end

  it 'should not accept a value with whitespace' do
    @tempest_config[:value] = 'b ar'
    expect(@tempest_config[:value]).to eq('b ar')
  end

  it 'should accept valid ensure values' do
    @tempest_config[:ensure] = :present
    expect(@tempest_config[:ensure]).to eq(:present)
    @tempest_config[:ensure] = :absent
    expect(@tempest_config[:ensure]).to eq(:absent)
  end

  it 'should not accept invalid ensure values' do
    expect {
      @tempest_config[:ensure] = :latest
    }.to raise_error(Puppet::Error, /Invalid value/)
  end

  it 'should autorequire the package that install the file' do
    catalog = Puppet::Resource::Catalog.new
    package = Puppet::Type.type(:package).new(:name => 'tempest')
    catalog.add_resource package, @tempest_config
    dependency = @tempest_config.autorequire
    expect(dependency.size).to eq(1)
    expect(dependency[0].target).to eq(@tempest_config)
    expect(dependency[0].source).to eq(package)
  end
end
