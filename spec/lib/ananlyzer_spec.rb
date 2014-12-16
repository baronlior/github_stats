require_relative '../spec_helper'
require_relative '../../lib/gem_file_parser'
require_relative '../../lib/analyzer'

describe 'Analyzer' do

  it 'find multiple versions of gems' do
    rep1 = GemfileParser.new [ 'gem "rails" , "~> 3.2.13"' ]
    rep2 = GemfileParser.new [ 'gem \'rails\', \'4.1.0\'']

    uut = Analyzer.new([rep1, rep2])
    verInfo = uut.getMultipleVersions

    expect(verInfo.keys.size).to be 1
    expect(verInfo['rails'].versions.size).to be 2
    expect(verInfo['rails'].versions.include? '~> 3.2.13').to be true
    expect(verInfo['rails'].versions.include? '4.1.0').to be true
  end

  it 'does not count the same version twice' do
    rep1 = GemfileParser.new [ 'gem "rails", "4.1.0"']
    rep2 = GemfileParser.new [ 'gem "rails" , "~> 3.2.13"' ]
    rep3 = GemfileParser.new [ 'gem \'rails\', \'4.1.0\'']

    uut = Analyzer.new([rep1, rep2, rep3])
    verInfo = uut.getMultipleVersions
    p verInfo
    expect(verInfo.keys.size).to be 1
    expect(verInfo['rails'].versions.size).to be 2
  end

end