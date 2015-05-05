require 'tmpdir'

module Services
  class Download
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

    class ArchiveBuilder
      TEMP_DIR = Rails.root.join('tmp')

      def initialize(configurator)
        @configurator = configurator
      end

      def build
        DeleteDownloadsJob.perform_now(File.join(TEMP_DIR, '*.zip'))

        zip_path = File.join(TEMP_DIR, File.basename(temp_dir) + '.zip')

        begin
          railsbox_dir = File.join(temp_dir, 'railsbox')
          Dir.mkdir(railsbox_dir)
          @configurator.save(railsbox_dir)
          Archiver.new(temp_dir).archive(zip_path)
        ensure
          FileUtils.remove_entry_secure temp_dir
        end

        zip_path
      end

      def temp_dir
        @temp_dir ||= Dir.mktmpdir
      end
    end

    def initialize(box)
      @box = box
    end

    def call
      configurator = Compilers::BoxConfigurator.from_params(@box.params || {})
      builder = ArchiveBuilder.new(configurator)
      path = builder.build

      OpenStruct.new path: path, file_name: configurator.file_name
    end
  end
end
