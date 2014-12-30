namespace :integration do
  desc 'Builds new configuration and copies it to the test_app_path'
  task copy: :environment do
    test_app_path = '/Users/akhkharu/projects/testapp'
    configurator = Configurator.from_params({
      databases: %w(postgresql mysql mongodb),
      vm_name: 'testapp',
      vm_os: 'ubuntu/trusty64',
      vm_memory: 1024,
      vm_cores: 2,
      vm_http_forwarded_port: 8080,
      vm_https_forwarded_port: 8081,
      server_name: 'localhost',
      ruby_version: 'ruby2.1',
      postgresql_db_name: 'testapp',
      postgresql_db_user: 'vagrant',
      postgresql_db_password: 'vagrant',
      mysql_db_name: 'testapp',
      mysql_db_user: 'vagrant',
      mysql_db_password: 'vagrant',
      mongodb_db_name: 'testapp',
      mongodb_orm: 'mongoid',
    })
    builder = ConfigurationBuilder.new(configurator)
    zip_path = builder.build
    `unzip -o #{zip_path} -d #{test_app_path}`
  end
end
