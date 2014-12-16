class Analyzer

  GemInfo = Struct.new(:versions) do
    def initialize
      self.versions = []
    end
  end

  def initialize(config_array)
    @configs = config_array
  end

  def getMultipleVersions
    result = {}

    @configs.each do |config|
      config.dependencies.each_key do | key |
        result[key] = GemInfo.new if result[key].nil?

        existing_gem_info = result[key]
        current_version = config.dependencies[key]

        unless existing_gem_info.versions.include? current_version
          existing_gem_info.versions << current_version
        end
      end
    end

    result
  end

end