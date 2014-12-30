%w(mongodb-org).each do |package|
  describe package(package) do
    it { should be_installed }
  end
end

describe service('mongod') do
  it { should be_enabled }
  it { should be_running }
end

describe port(27017) do
  it { should be_listening }
end

describe file('/vagrant/config/mongoid.rb') do
  its(:content) { should match /database: testapp_development/ }
  its(:content) { should match /localhost:27017/ }
end
