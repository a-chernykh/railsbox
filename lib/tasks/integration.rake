require File.expand_path('../../../spec/support/test_helpers/params_fixtures', __FILE__)

namespace :integration do
  desc 'Builds new configuration and copies it to the test_app_path'
  task copy: :environment do
    include TestHelpers::ParamsFixtures
    test_app_path = '/Users/akhkharu/projects/testapp'
    configurator = Configurator.from_params(params_fixture)
    builder = ConfigurationBuilder.new(configurator)
    zip_path = builder.build
    `unzip -o #{zip_path} -d #{test_app_path}`
  end

  task roadar: :environment do
    config = { 
      databases: %w(postgresql redis),
      background_jobs: %w(sidekiq),
      vm_name: 'roadar',
      vm_os: 'ubuntu/trusty64-prepackaged',
      vm_memory: 1500,
      vm_swap: 1024,
      vm_cores: 2,
      vm_ports: {
        '0' => { guest: 80, host: 8080 },
        '1' => { guest: 443, host: 8081 },
      },
      server_name: 'localhost',
      ruby_type: 'rvm',
      ruby_version: '2.1.2',
      rails_version: '4',
      postgresql_db_name: 'roadar',
      postgresql_db_user: 'vagrant',
      postgresql_db_password: '',
      postgresql_orm: 'activerecord',
      sidekiq_app_name: 'roadar-sidekiq',
      sidekiq_command: 'sidekiq',
      packages: %w(imagemagick qt5-default libqt5webkit5-dev)
    }

    test_app_path = '/Users/akhkharu/projects/RoadAR-website'
    configurator = Configurator.from_params(config)
    builder = ConfigurationBuilder.new(configurator)
    zip_path = builder.build
    `unzip -o #{zip_path} -d #{test_app_path}`
  end
end
