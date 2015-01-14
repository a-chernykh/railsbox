class TemplateContext
  def initialize(params)
    @params = params
  end

  def roles
    @params[:databases] + @params[:background_jobs]
  end

  def server_role
    @params[:server_type].sub 'nginx_', ''
  end
end
