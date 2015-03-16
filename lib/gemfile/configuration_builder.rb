module Gemfile
  class ConfigurationBuilder
    def initialize(base)
      @configuration = base.dup
    end

    def set_ruby_version(ruby_version)
      @configuration[:ruby_version] = ruby_version
    end

    def add_gem(gem_name)
      ConfigurationRules.for(gem_name).apply(@configuration)
    end

    def get
      @configuration
    end
  end
end
