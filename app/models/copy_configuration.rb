class CopyConfiguration < BaseConfiguration
  def initialize(params)
    @params = params
  end

  def save(output_dir)
    process_recursive(Templates::ROOT_PATH, '', output_dir) do |source_path, target_path|
      FileUtils.cp source_path, target_path
    end
  end

  private

  def optional_roles
    @optional_roles ||= Box.databases.map(&:id) + Box.background_jobs.map(&:id)
  end

  def selected_roles
    @selected_roles ||= @params[:databases] + @params[:background_jobs]
  end

  def skip_roles_paths
    @skip_roles_paths ||= (optional_roles - selected_roles).map { |role| "ansible/roles/#{role}" }
  end

  def process_file?(file)
    skip_roles_paths.none? { |path| file.include?(path) }
  end
end
