class ConfigurationBuilder
  def initialize(configurator)
    @configurator = configurator
  end

  def build
    zip_path = Rails.root.join('tmp', File.basename(temp_dir) + '.zip')

    begin
      devops_dir = File.join(temp_dir, 'devops')
      Dir.mkdir(devops_dir)
      @configurator.save(devops_dir)
      Archiver.new(temp_dir).archive(zip_path)
    ensure
      FileUtils.remove_entry_secure temp_dir
    end

    zip_path
  end

  def temp_dir
    @temp_dir ||= Dir.mktmpdir
  end
end
