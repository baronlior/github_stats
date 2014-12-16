require 'awesome_print'

class GemfileParser

  attr_accessor :dependencies

  def initialize(lines)
    lines = filter_gems lines
    @dependencies = extract_gem_data lines
  end

  def puts_dependencies
    ap @dependencies, {raw: true}
  end

  protected

  def filter_gems(lines)
    result = []
    lines.each do |line|
      result << line if line.include? 'gem'
    end
    result
  end

  def remove_quotes(str)
    str.gsub(/\A"|"\Z/, '')
  end

  def extract_gem_data_line(line)
    line.slice! 'gem'

    tokens = line.split(',').map(&:strip)
    tokens[0] = remove_quotes(tokens[0])
    
    if tokens.length == 1
      { tokens[0] => ''}
    else
      { tokens[0] => remove_quotes(tokens[1]) }
    end
  end

  def extract_gem_data(lines)
    result = {}

    lines.each do |line|
      result.merge!(extract_gem_data_line(line))
    end

    result
  end

end
