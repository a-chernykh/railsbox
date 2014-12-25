class Templates
  ROOT_PATH = 'app/templates'
  EXT = '.erb'

  def self.path(template)
    File.join(ROOT_PATH, template)
  end
end
