require 'spec_helper'

describe 'tempest::config' do
  let :params do
    {
      :tempest_config => {
        'DEFAULT/foo' => { 'value'  => 'fooValue' },
        'DEFAULT/bar' => { 'value'  => 'barValue' },
        'DEFAULT/baz' => { 'ensure' => 'absent' }
      }
    }
  end

  shared_examples 'tempest::config' do
    it {
      is_expected.to contain_tempest_config('DEFAULT/foo').with_value('fooValue')
      is_expected.to contain_tempest_config('DEFAULT/bar').with_value('barValue')
      is_expected.to contain_tempest_config('DEFAULT/baz').with_ensure('absent')
    }
  end

  on_supported_os({
    :supported_os => OSDefaults.get_supported_os
  }).each do |os,facts|
    context "on #{os}" do
      let (:facts) do
        facts.merge!(OSDefaults.get_facts())
      end

      it_behaves_like 'tempest::config'
    end
  end
end
