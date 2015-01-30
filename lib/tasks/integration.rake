require File.expand_path('../../../spec/support/test_helpers/params_fixtures', __FILE__)

namespace :integration do
  task testapp1: :environment do
    config = {
      databases: %w(postgresql redis),
      background_jobs: %w(sidekiq),
      autoconf: true,
      docker: false,
      vm_name: 'testapp1',
      vm_os: 'ubuntu/trusty64',
      vm_ip: '192.168.59.104',
      vm_shared_directory: '/vagrant',
      vm_share_type: 'nfs',
      vm_memory: 1500,
      vm_swap: 1024,
      vm_cores: 2,
      vm_ports: {
        '0' => { guest: 80, host: 8080 },
        '1' => { guest: 443, host: 8081 },
      },
      server_name: 'localhost',
      server_type: 'nginx_passenger',
      ruby_install: 'package',
      ruby_version: 'ruby2.2',
      rails_version: '4',
      postgresql_db_name: 'testapp1',
      postgresql_db_user: 'vagrant',
      postgresql_db_password: '',
      postgresql_orm: '',
      postgresql_extensions: [  ],
      sidekiq_app_name: 'testapp1-sidekiq',
      sidekiq_command: 'sidekiq',
      packages: %w(),
      environment_file: '/vagrant/.envrc'
    }

    test_app_path = Rails.root.join('spec/fixtures/testapp1')
    configurator = BoxConfigurator.from_params(config)
    builder = ArchiveBuilder.new(configurator)
    zip_path = builder.build
    `unzip -o #{zip_path} -d #{test_app_path}`
  end
end
