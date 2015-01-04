%w(mysql-server libmysqlclient-dev).each do |package|
  describe package(package) do
    it { should be_installed }
  end
end

describe service('mysql') do
  it { should be_enabled }
  it { should be_running }
end

describe port(3306) do
  it { should be_listening }
end

describe file('/vagrant/config/database.yml') do
  its(:content) { should match /database: testapp/ }
  its(:content) { should match /username: vagrant/ }
  its(:content) { should match /password: vagrant/ }
end
