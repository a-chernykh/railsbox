module TestHelpers
  module ZipContents
    def zip_list_of_files(data)
      files = []
      process_zip_data(data) do |zipfile|
        files = zipfile.entries.map(&:name)
      end
      files
    end

    # the client is reponsible for deleting dir
    def extract_zip(data)
      dir = Dir.mktmpdir
      process_zip_data(data) do |zipfile|
        zipfile.each do |f|
         f_path = File.join(dir, f.name)
         FileUtils.mkdir_p(File.dirname(f_path))
         zipfile.extract(f, f_path) unless File.exist?(f_path)
        end
      end
      dir
    end

    def process_zip_data(data)
      zip = Tempfile.new 'zip_contents'

      begin
        zip.write data
        zip.close

        # Zip::File.open_buffer is buggy, that's why we need to create
        # Tempfile and work with it
        Zip::File.open(zip.path) do |zipfile|
          yield zipfile
        end
      ensure
        zip.unlink
      end
    end
  end
end
