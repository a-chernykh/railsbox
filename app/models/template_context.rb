class TemplateContext
  def initialize(params)
    @params = params
  end

  def render(partial)
    template = Tilt.new partial_path(partial)
    template.render(self, params: @params)
  end

  def roles
    @params[:databases] + @params[:background_jobs]
  end

  def server_role
    @params[:server_type].sub 'nginx_', ''
  end

  def docker_ports_for(role)
    port = Databases.port_for(role)
    if port
      [%Q('#{port}:#{port}')]
    else
      []
    end
  end

  private

  def partial_path(partial)
    File.join Templates::ROOT_PATH, "_#{partial}.erb"
  end
end
