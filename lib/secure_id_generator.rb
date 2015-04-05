class SecureIdGenerator
  def self.generate
    SecureRandom.uuid.gsub('-', '')[0...12]
  end
end
