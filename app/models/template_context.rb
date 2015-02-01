class TemplateContext
  def initialize(params)
    @params = params
  end

  def params
    @params
  end

  def render(partial)
    template = Tilt.new partial_path(partial)
    template.render(self, params: @params)
  end

  include TemplateHelpers::Vagrant
  include TemplateHelpers::Docker
  include TemplateHelpers::Roles

  private

  def partial_path(partial)
    parts = partial.split('/')
    parts.unshift Templates::ROOT_PATH
    parts[-1] = "_#{parts[-1]}.erb"
    File.join parts
  end
end
