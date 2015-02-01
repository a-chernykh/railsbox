class ConfigurationCleanup
  def save(output_dir)
    FileUtils.remove_entry_secure(File.join(output_dir, 'environment'))
  end
end
