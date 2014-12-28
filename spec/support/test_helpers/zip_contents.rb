module TestHelpers
  module ZipContents
    def zip_list_of_files(data)
      zip = Tempfile.new 'zip_contents'
      files = []

      begin
        zip.write data
        zip.close

        # Zip::File.open_buffer is buggy, that's why we need to create
        # Tempfile and work with it
        Zip::File.open(zip.path) do |zipfile|
          files = zipfile.entries.map(&:name)
        end
      ensure
        zip.unlink
      end

      files
    end
  end
end
