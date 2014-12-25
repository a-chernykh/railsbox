class TemplateConfiguration
  def initialize(params)
    @params = params
  end

  def save(output_dir)
    copy_recursive Templates::ROOT_PATH, output_dir
  end

  private

  def copy_recursive(dir, output_dir)
    Dir.foreach(dir) do |f|
      next if f.in?(['.', '..'])
      full_path = File.join(dir, f)
      if File.directory?(full_path)
        copy_recursive full_path, output_dir
      elsif File.extname(f) == Templates::EXT
        target_dir = File.join(output_dir, dir.gsub(Templates::ROOT_PATH, ''))
        target_path = File.join(target_dir, f).gsub('.erb', '')
        FileUtils.mkdir_p target_dir unless File.exist?(target_dir)
        template = Tilt.new full_path
        File.open(target_path, 'w') do |f|
          f.write template.render(Object.new, @params)
        end
      end
    end
  end
end
