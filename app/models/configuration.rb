class Configuration
  def initialize(configurators)
    @configurators = configurators
  end

  def save(output_dir)
    @configurators.each do |configurator|
      configurator.save output_dir
    end
  end
end
