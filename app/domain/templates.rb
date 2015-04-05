module Templates
  ROOT_PATH = 'templates'
  EXT = '.erb'

  module_function

  def path(template)
    File.join(ROOT_PATH, template)
  end
end
