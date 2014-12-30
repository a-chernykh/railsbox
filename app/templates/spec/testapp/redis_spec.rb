%w(redis-server).each do |package|
  describe package(package) do
    it { should be_installed }
  end
end

describe service('redis-server') do
  it { should be_enabled }
  it { should be_running }
end

describe port(6379) do
  it { should be_listening }
end

describe file('/vagrant/config/initializers/redis.rb') do
  it { should contain "$redis = Redis.new(:host => 'localhost', :port => 6379)" }
end
