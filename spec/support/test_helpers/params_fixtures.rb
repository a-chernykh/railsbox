module TestHelpers
  module ParamsFixtures
    def params_fixture
      { databases: %w(postgresql mysql mongodb redis),
        background_jobs: %w(delayed_job sidekiq),
        vm_name: 'testapp',
        vm_os: 'ubuntu/trusty64',
        vm_memory: 1024,
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
        postgresql_db_name: 'testapp',
        postgresql_db_user: 'vagrant',
        postgresql_db_password: 'vagrant',
        postgresql_orm: 'activerecord',
        mysql_db_name: 'testapp',
        mysql_db_user: 'vagrant',
        mysql_db_password: 'vagrant',
        mysql_orm: 'activerecord',
        mongodb_db_name: 'testapp',
        mongodb_orm: 'mongoid',
        redis_orm: 'redis-rb',
        delayed_job_app_name: 'testapp-delayed_job',
        delayed_job_command: 'bin/delayed_job run',
        sidekiq_app_name: 'testapp-sidekiq',
        sidekiq_command: 'sidekiq' }
    end
  end
end
