RSpec::Matchers.define :file_exists do |sample|
  match do |path|
    File.exists?(path)
  end

  failure_message do |path|
    dir = File.dirname(path)
    files = `ls -lah #{dir}`
    "expected file #{path} to exists, #{dir} contents: #{files}"
  end
end
