feature 'Provision boxes', js: true do
  scenario 'rbenv, unicorn, PostgreSQL, redis, sidekiq' do
    zip_data = download_box 'rbenv', 'unicorn', 'postgresql', 'redis', 'sidekiq'
    test_box(zip_data, 'testapp1')
  end

  scenario 'rvm, unicorn, PostgreSQL, redis, sidekiq' do
    zip_data = download_box 'rvm', 'unicorn', 'postgresql', 'redis', 'sidekiq'
    test_box(zip_data, 'testapp1')
  end
end
