namespace :integration do
  desc 'Builds new configuration and copies it to the test_app_path'
  task copy: :environment do
    test_app_path = '/Users/akhkharu/projects/testapp'
    configurator = Configurator.from_params({
      vm_name: 'testapp',
      vm_os: 'ubuntu/trusty64',
      vm_memory: 1024,
      vm_cores: 2,
      vm_forwarded_port: 8080,
      server_name: 'localhost',
      ruby_version: 'ruby2.1',
      database_name: 'testapp',
      database_user: 'testapp'
    })
    builder = ConfigurationBuilder.new(configurator)
    zip_path = builder.build
    `unzip -o #{zip_path} -d #{test_app_path}`
  end
end
