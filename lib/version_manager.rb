class VersionManager
  def self.current_version
    @current_version ||= new.current_version
  end

  def current_version
    version_tag = git_tags.find { |t| t =~ /v\d/ }
    version_tag.gsub('v', '') if version_tag
  end

  private

  def git_tags
    tags = `git describe --tags HEAD`
    $?.exitstatus == 0 ? tags.split("\n") : []
  end
end
