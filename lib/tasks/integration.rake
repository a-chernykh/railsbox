require File.expand_path('../../../spec/support/test_helpers/params_fixtures', __FILE__)

namespace :integration do
  task testapp1: :environment do
    config = {
      databases: %w(postgresql redis),
      background_jobs: %w(sidekiq),
      autoconf: true,
      docker: true,
      apt_proxy: true,
      vm_name: 'roadar',
      vm_os: 'ubuntu/trusty64',
      vm_ip: '192.168.59.104',
      vm_shared_directory: '/vagrant',
      vm_share_type: 'NFS',
      vm_memory: 1500,
      vm_swap: 1024,
      vm_cores: 2,
      vm_ports: {
        '0' => { guest: 80, host: 8080 },
        '1' => { guest: 443, host: 8081 },
      },
      server_name: 'localhost',
      server_type: 'nginx_passenger',
      ruby_install: 'rbenv',
      ruby_version: '2.1.2',
      rails_version: '4',
      postgresql_db_name: 'roadar',
      postgresql_db_user: 'vagrant',
      postgresql_db_password: '',
      postgresql_orm: '',
      postgresql_extensions: [ 'hstore', 'postgis' ],
      sidekiq_app_name: 'roadar-sidekiq',
      sidekiq_command: 'sidekiq',
      packages: %w(imagemagick qt5-default libqt5webkit5-dev),
      environment_file: '/vagrant/.envrc'
    }

    test_app_path = Rails.root.join('spec/fixtures/testapp1')
    configurator = BoxConfigurator.from_params(config)
    builder = ArchiveBuilder.new(configurator)
    zip_path = builder.build
    `unzip -o #{zip_path} -d #{test_app_path}`
  end
end
