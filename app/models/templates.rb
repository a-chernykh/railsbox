class Templates
  ROOT_PATH = 'app/templates'

  def self.path(template)
    File.join(ROOT_PATH, template)
  end
end
