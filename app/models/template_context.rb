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

  private

  def partial_path(partial)
    File.join Templates::ROOT_PATH, "_#{partial}.erb"
  end
end
