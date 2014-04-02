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
    @tempest_config[:value].should == 'bar'
  end

  it 'should not accept a value with whitespace' do
    @tempest_config[:value] = 'b ar'
    @tempest_config[:value].should == 'b ar'
  end

  it 'should accept valid ensure values' do
    @tempest_config[:ensure] = :present
    @tempest_config[:ensure].should == :present
    @tempest_config[:ensure] = :absent
    @tempest_config[:ensure].should == :absent
  end

  it 'should not accept invalid ensure values' do
    expect {
      @tempest_config[:ensure] = :latest
    }.to raise_error(Puppet::Error, /Invalid value/)
  end
end
