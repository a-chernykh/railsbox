class Configurator
  def initialize(configurators)
    @configurators = configurators
  end

  def self.from_params(params)
    new([ CopyConfiguration.new,
          TemplateConfiguration.new(params) ])
  end

  def save(output_dir)
    @configurators.each do |configurator|
      configurator.save output_dir
    end
  end
end
