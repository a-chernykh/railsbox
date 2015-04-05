module Compilers
  class BoxConfigurator < Base
    def initialize(configurators, name)
      @configurators = configurators
      @name = name
    end

    def self.from_params(params)
      default_params = DefaultConfiguration.base
      params = ActiveSupport::HashWithIndifferentAccess.new(default_params.merge(params.symbolize_keys))
      new([Copy.new(params),
           Environments.new(params),
           Template.new(params),
           Cleanup.new], params[:vm_name])
    end

    def file_name
      [@name.gsub(/[^a-z0-9\-_]+/i, ''), '-railsbox.zip'].join
    end

    def save(output_dir)
      @configurators.each do |configurator|
        configurator.save output_dir
      end
    end
  end
end
