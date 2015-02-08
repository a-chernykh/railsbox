class TemplateContext
  def initialize(path, params)
    @path = path
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
    parts[-1] = "_#{parts[-1]}.erb"
    File.join File.dirname(@path), parts
  end
end
