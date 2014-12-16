require_relative 'lib/file_loader'
require_relative 'lib/gem_file_parser'

dep = []
dep << (GemfileParser.new FileLoader.get_content('chef.Gemfile.txt'))
dep[0].puts_dependencies




