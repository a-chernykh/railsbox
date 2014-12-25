class VagrantConfiguration
  def initialize(params)
    @params = params
  end

  def self.template_path
    Templates.path('Vagrantfile.erb')
  end

  def save(output_dir)
    template = Tilt.new self.class.template_path
    File.open(File.join(output_dir, 'Vagrantfile'), 'w') do |f|
      f.write template.render(Object.new, @params)
    end
  end
end
