class TemplateConfiguration < BaseConfiguration
  def initialize(params)
    @params = params
  end

  def save(output_dir)
    partials = []

    process_recursive(output_dir, '', output_dir) do |source_path, target_path|
      if File.basename(source_path)[0] != '_'
        target_path.gsub!('.erb', '')
        template = Tilt.new source_path
        File.open(target_path, 'w') do |f|
          f.write template.render(TemplateContext.new(@params), params: @params)
        end
        FileUtils.rm_f source_path
      else
        partials << source_path
      end
    end

    partials.each { |p| FileUtils.rm_f p }
  end

  private

  def process_file?(file)
    File.extname(file) == Templates::EXT
  end
end
