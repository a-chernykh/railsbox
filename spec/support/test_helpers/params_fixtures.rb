module TestHelpers
  module ParamsFixtures
    def params_fixture
      { databases: %w(postgresql mysql mongodb),
        vm_name: 'myapp',
        vm_os: 'ubuntu/trusty64',
        vm_memory: 700,
        vm_cores: 2,
        vm_http_forwarded_port: 8080,
        vm_https_forwarded_port: 8081,
        server_name: 'localhost',
        ruby_version: '2.1.2',
        postgresql_db_name: 'myapp',
        postgresql_db_user: 'vagrant',
        postgresql_db_password: 'vagrant',
        postgresql_orm: 'activerecord',
        mysql_db_name: 'myapp',
        mysql_db_user: 'vagrant',
        mysql_db_password: 'vagrant',
        mongodb_db_name: 'myapp',
        mongodb_orm: 'mongoid' }
    end
  end
end
