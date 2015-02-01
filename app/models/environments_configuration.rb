class EnvironmentsConfiguration < BaseConfiguration
  def initialize(params)
    @params = params
  end

  def save(output_dir)
    environments.each do |environment|
      environment_path = File.join(output_dir, environment)
      FileUtils.mkdir_p environment_path

      process_recursive(File.join(output_dir, 'environment'), '', environment_path) do |source_path, target_path|
        if File.extname(source_path) == Templates::EXT && File.basename(source_path)[0] != '_'
          target_path.gsub!('.erb', '')
          render(source_path, target_path.gsub('.erb', ''), @params[environment.to_sym])
        end
      end
    end
  end

  private

  def process_file?(file)
    true
  end

  def environments
    %w(development staging production) & @params.keys.map(&:to_s)
  end
end
