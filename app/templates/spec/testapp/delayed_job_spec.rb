describe service('testapp-delayed_job') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/init/testapp-delayed_job.conf') do
  it { should contain('bin/delayed_job run') }
end
