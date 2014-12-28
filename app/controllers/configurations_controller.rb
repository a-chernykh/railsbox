class ConfigurationsController < ApplicationController
  def create
    tmp_dir = Dir.mktmpdir
    devops_dir = File.join(tmp_dir, 'devops')
    Dir.mkdir(devops_dir)
    zip_path = Rails.root.join('tmp', File.basename(tmp_dir) + '.zip')
    begin
      ::Configuration.from_params(params).save(devops_dir)
      Archiver.new(tmp_dir).archive(zip_path)

      send_file zip_path, filename: 'configuration.zip'
    ensure
      # FileUtils.remove_entry_secure zip_path
      FileUtils.remove_entry_secure tmp_dir
    end
  end
end
