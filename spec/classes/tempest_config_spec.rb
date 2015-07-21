require 'spec_helper'

describe 'tempest::config' do

  let :params do
    { :tempest_config => {
        'DEFAULT/foo' => { 'value'  => 'fooValue' },
        'DEFAULT/bar' => { 'value'  => 'barValue' },
        'DEFAULT/baz' => { 'ensure' => 'absent' }
      }
    }
  end

  it 'configures arbitrary tempest configurations' do
    is_expected.to contain_tempest_config('DEFAULT/foo').with_value('fooValue')
    is_expected.to contain_tempest_config('DEFAULT/bar').with_value('barValue')
    is_expected.to contain_tempest_config('DEFAULT/baz').with_ensure('absent')
  end

end
