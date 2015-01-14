class BoxConfigurator
  def initialize(configurators, name)
    @configurators = configurators
    @name = name
  end

  def self.default_params
    { databases: [],
      background_jobs: [],
      vm_ports: {},
      packages: [],
      manual_ruby_version: nil,
      server_type: 'nginx_unicorn', }
  end

  def self.from_params(params)
    params = ActiveSupport::HashWithIndifferentAccess.new(default_params.merge(params.symbolize_keys))
    new([ CopyConfiguration.new(params),
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
