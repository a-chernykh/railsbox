class TemplateConfiguration < BaseConfiguration
  def initialize(params)
    @params = params
  end

  def save(output_dir)
    process_recursive(output_dir, '', output_dir) do |source_path, target_path|
      if File.basename(source_path)[0] != '_'
        target_path.gsub!('.erb', '')
        render(source_path, target_path.gsub('.erb', ''))
        FileUtils.rm_f source_path
      end
    end
  end

  private

  def process_file?(file)
    File.extname(file) == Templates::EXT && !file.include?('/environment/')
  end
end
