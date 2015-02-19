feature 'Provision boxes', js: true, vagrant: true do
  scenario 'rbenv, unicorn, PostgreSQL, redis, sidekiq' do
    test_box(app: 'testapp1', 
             components: ['rbenv', 'unicorn', 'postgresql', 'redis', 'sidekiq'])
  end

  scenario 'rvm, unicorn, PostgreSQL, redis, sidekiq' do
    test_box(app: 'testapp1', 
             components: ['rvm', 'unicorn', 'postgresql', 'redis', 'sidekiq'])
  end

  scenario 'system_package, passenger, MySQL, delayed_job' do
    test_box(app: 'testapp2', 
             components: ['system_package', 'passenger', 'mysql', 'delayed_job'])
  end

  scenario '(no ansible installed) system_package, passenger, MySQL' do
    test_box(app: 'testapp2', 
             components: ['system_package', 'passenger', 'mysql'],
             ansible: false)
  end

  scenario '(remote server) system_package, passenger, MySQL' do
    test_box(app: 'testapp2', 
             components: ['system_package', 'passenger', 'mysql'],
             target: 'server')
  end
end
