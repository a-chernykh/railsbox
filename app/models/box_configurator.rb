class BoxConfigurator
  def initialize(configurators, name)
    @configurators = configurators
    @name = name
  end

  def self.from_params(params)
    params = ActiveSupport::HashWithIndifferentAccess.new(params)
    new([ CopyConfiguration.new,
          TemplateConfiguration.new(params) ], params[:vm_name])
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
