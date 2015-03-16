module Services
  class GemfileToConfiguration
    class Result
      attr_accessor :data, :success

      def success?
        success
      end
    end

    def initialize(gemfile)
      @gemfile = gemfile
    end

    def call
      result = Result.new

      begin
        parser = Gemfile::Parser.new(@gemfile)
        builder = Gemfile::ConfigurationBuilder.new(DefaultConfiguration.get)

        parser.gems.each { |gem_name| builder.add_gem gem_name }
        builder.set_ruby_version parser.ruby_version if parser.ruby_version

        result.data = builder.get
        result.success = true
      rescue Parser::SyntaxError, EncodingError
        result.data = { error: 'Error parsing Gemfile' }
        result.success = false
      end

      result
    end
  end
end
