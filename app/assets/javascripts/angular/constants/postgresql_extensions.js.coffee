angular
  .module('app.railsbox')
  .constant 'POSTGRESQL_EXTENSIONS', [
      { name: 'hstore' },
      { name: 'citext' },
      { name: 'postgis' } 
    ]
