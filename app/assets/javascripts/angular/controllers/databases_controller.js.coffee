angular.module('app.rubyops').classy.controller
  name: 'DatabasesController'
  inject: ['$scope']

  init: ->
    @$.allObjects = [
      { id: 'postgresql', name: 'PostgreSQL' },
      { id: 'mysql',      name: 'MySQL' },
      { id: 'mongodb',    name: 'MongoDB' },
      { id: 'redis',      name: 'Redis' },
    ]
    @$.activeObjects = ['postgresql']

    @$.sqlOrm = ''
    @$.mongodbOrm = ''
    @$.redisOrm = ''

    @$.postgresql = 
      extensions: [ 
        { name: 'hstore' },
        { name: 'citext' },
        { name: 'postgis' }
      ]

  watch:
    'sqlOrm': '_onSqlOrmChange'
    'mongodbOrm': '_onMongodbOrmChange'

  _onSqlOrmChange: (newValue) ->
    @$.sqlConfigPath = switch newValue
      when 'activerecord', 'sequel', 'datamapper' then 'config/database.yml'

  _onMongodbOrmChange: (newValue) ->
    @$.mongodbConfigPath = switch newValue
      when 'mongoid' then 'config/mongoid.yml'
      when 'mongomapper' then 'config/mongo.yml'
