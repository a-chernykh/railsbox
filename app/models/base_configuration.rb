class BaseConfiguration
  private

  def process_recursive(dir, output_dir, &block)
    Dir.foreach(dir) do |f|
      next if f.in?(['.', '..'])

      full_path = File.join(dir, f)
      if File.directory?(full_path)
        process_recursive(full_path, output_dir, &block)
      elsif process_file?(f)
        target_dir = File.join(output_dir, dir.sub(Templates::ROOT_PATH, ''))
        target_path = File.join(target_dir, f)
        FileUtils.mkdir_p target_dir unless File.exist?(target_dir)
        yield full_path, target_path
      end
    end
  end
end
