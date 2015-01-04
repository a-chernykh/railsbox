class TemplateConfiguration < BaseConfiguration
  def initialize(params)
    @params = params
  end

  def save(output_dir)
    process_recursive(Templates::ROOT_PATH, output_dir) do |source_path, target_path|
      target_path.gsub!('.erb', '')
      template = Tilt.new source_path
      File.open(target_path, 'w') do |f|
        f.write template.render(Object.new, params: default_params.merge(@params).symbolize_keys)
      end
    end
  end

  private

  def process_file?(file)
    File.extname(file) == Templates::EXT
  end

  def default_params
    { databases: [],
      background_jobs: [],
      vm_ports: {},
      packages: [],
      manual_ruby_version: nil }
  end
end
