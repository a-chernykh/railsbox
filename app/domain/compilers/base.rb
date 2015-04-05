module Compilers
  class Base
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

    def render(template_path, output_path, additional_params={})
      template = Tilt.new template_path
      mode = File.stat(template_path).mode
      params = @params.merge(additional_params)
      File.open(output_path, 'w') do |f|
        f.write template.render(Templates::Context.new(template_path, params), params: params)
        f.chmod mode
      end
    end
  end
end
