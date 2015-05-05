class DeleteDownloadsJob < ActiveJob::Base
  def perform(path)
    files = Dir[path]
    FileUtils.rm files
  end
end
