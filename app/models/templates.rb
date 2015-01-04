class Templates
  ROOT_PATH = 'templates'
  EXT = '.erb'

  def self.path(template)
    File.join(ROOT_PATH, template)
  end
end
