class BaseConfiguration
  private

  def process_recursive(source_dir, source_path, output_dir, &block)
    Dir.foreach(File.join(source_dir, source_path)) do |f|
      next if f.in?(['.', '..'])

      full_path = File.join(source_dir, source_path, f)
      if File.directory?(full_path)
        process_recursive(source_dir, File.join(source_path, f), output_dir, &block)
      elsif process_file?(full_path)
        target_dir = File.join(output_dir, source_path)
        target_path = File.join(target_dir, f)
        yield full_path, target_path
      end
    end
  end
end
