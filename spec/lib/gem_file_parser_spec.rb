require_relative '../spec_helper'
require_relative '../../lib/gem_file_parser'

# TODO: why spec_helper not found?
# TODO: why I require relative - but all code examples doesn't
# TODO: how do I test protected methods?


# remember to execute "$ rspec --init" on the project's root
# folder conventions: spec/anything else


describe 'My behaviour' do

  before(:each) do
#    @uut = GemfileParser.new []
#    GemfileParser.send(:public, *GemfileParser.protected_instance_methods)
  end

  it 'empty file does not break the code' do # 'it' called "example", 'should line' called "expectation", should == modifier, == called matcher
    uut = GemfileParser.new []
    expect(uut.dependencies.size).to be 0
  end

  it 'extract a line with only gem name' do
    uut = GemfileParser.new ['gem "bson_ext"']
    expect(uut.dependencies.size).to be 1
    expect(uut.dependencies.keys[0]).to eq 'bson_ext'
  end

  it 'extract a line with only gem name and version' do
    uut = GemfileParser.new ['gem "rails" , "~> 3.2.13" ']
    expect(uut.dependencies.size).to be 1
    expect(uut.dependencies.keys[0]).to eq 'rails'
    expect(uut.dependencies.values[0]).to eq '~> 3.2.13'
  end

  it 'extract multiple lines correctly' do
    uut = GemfileParser.new ['gem "rails"  ,  "~> 3.2.13" ', ' gem  "json" ']
    expect(uut.dependencies.size).to be 2
    expect(uut.dependencies.values[0]).to eq '~> 3.2.13'
    expect(uut.dependencies.keys[1]).to eq 'json'
  end


end