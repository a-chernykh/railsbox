describe service('testapp-sidekiq') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/init/testapp-sidekiq.conf') do
  it { should contain('bundle exec sidekiq') }
end
