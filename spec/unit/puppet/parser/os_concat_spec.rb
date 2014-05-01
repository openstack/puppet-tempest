#! /usr/bin/env ruby -S rspec
require 'spec_helper'

describe "the os_concat function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should raise a ParseError if the client does not provide two arguments" do
    lambda { scope.function_os_concat([]) }.should(raise_error(Puppet::ParseError))
  end

  it "should raise a ParseError if the first parameter is not an array" do
    lambda { scope.function_os_concat([1, []])}.should(raise_error(Puppet::ParseError))
  end

  it "should be able to os_concat an array" do
    result = scope.function_os_concat([['1','2','3'],['4','5','6']])
    result.should(eq(['1','2','3','4','5','6']))
  end

  it "should be able to os_concat a primitive to an array" do
    result = scope.function_os_concat([['1','2','3'],'4'])
    result.should(eq(['1','2','3','4']))
  end

  it "should not accidentally flatten nested arrays" do
    result = scope.function_os_concat([['1','2','3'],[['4','5'],'6']])
    result.should(eq(['1','2','3',['4','5'],'6']))
  end

end
