class CopyConfiguration < BaseConfiguration
  def initialize(params)
    @params = params
  end

  def save(output_dir)
    process_recursive(Templates::ROOT_PATH, '', output_dir) do |source_path, target_path|
      custom_rules.each do |k, v|
        if source_path.include?(k)
          target_path = v ? target_path.gsub(k, v) : nil
          break
        end
      end

      FileUtils.cp source_path, target_path unless target_path.nil?
    end
  end

  private

  def custom_rules
    if @params[:docker]
      { 'Vagrantfile.docker.erb' => 'Vagrantfile.erb',
        'Vagrantfile.single.erb' => nil }.freeze
    else
      { 'Vagrantfile.single.erb'     => 'Vagrantfile.erb',
        'Vagrantfile.docker.erb'     => nil,
        'Vagrantfile.dockerhost.erb' => nil,
        'ansible/roles/docker'       => nil }.freeze
    end
  end

  def optional_roles
    @optional_roles ||= Databases.list.map(&:id) + Box.background_jobs.map(&:id)
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
