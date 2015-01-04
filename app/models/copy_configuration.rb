class CopyConfiguration < BaseConfiguration
  def save(output_dir)
    process_recursive(Templates::ROOT_PATH, output_dir) do |source_path, target_path|
      FileUtils.cp source_path, target_path
    end
  end

  private

  def process_file?(file)
    File.extname(file) != Templates::EXT
  end
end
