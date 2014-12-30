module TestHelpers
  module ParamsFixtures
    def params_fixture
      { databases: %w(postgresql mysql mongodb redis),
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
        postgresql_orm: 'activerecord',
        mysql_db_name: 'testapp',
        mysql_db_user: 'vagrant',
        mysql_db_password: 'vagrant',
        mysql_orm: 'activerecord',
        mongodb_db_name: 'testapp',
        mongodb_orm: 'mongoid' }
    end
  end
end
