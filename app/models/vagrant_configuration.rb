class VagrantConfiguration
  def initialize(params)
    @params = params
  end

  def save(file)
    template = Tilt.new Templates.path('Vagrantfile.erb')
    file.write template.render(Object.new, @params)
  end
end
