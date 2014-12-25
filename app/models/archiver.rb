class Archiver
  def initialize(dir)
    @dir = dir
  end

  def archive(zip_path)
    Zip::File.open(zip_path, Zip::File::CREATE) do |zipfile|
      add_recursive(zipfile, @dir)
    end
  end

  private

  def add_recursive(zipfile, dir)
    Dir.foreach(dir) do |f|
      next if f.in?(['.', '..'])
      full_path = File.join(dir, f)
      relative_path = full_path.gsub(@dir.to_s, '').gsub(/^\//, '')
      if File.directory?(full_path)
        zipfile.mkdir relative_path
        add_recursive zipfile, full_path
      else
        zipfile.add(relative_path, full_path)
      end
    end
  end
end
