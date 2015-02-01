angular.module('app.railsbox').classy.controller
  name: 'DatabasesController'
  inject: ['$scope']

  init: ->
    @$.allObjects = [
      { id: 'postgresql', name: I18n.t('boxes.form.postgresql') },
      { id: 'mysql',      name: I18n.t('boxes.form.mysql') },
      { id: 'mongodb',    name: I18n.t('boxes.form.mongodb') },
      { id: 'redis',      name: I18n.t('boxes.form.redis') },
    ]
    @$.activeObjects = []

  watch:
    'configuration.mongodb_orm': '_onMongodbOrmChange'
    'configuration.databases': '_onDatabasesChange'
    'configuration.mysql_orm': '_onSqlOrmChange'
    'configuration.postgresql_orm': '_onSqlOrmChange'

  _onSqlOrmChange: (newValue) ->
    if @$.configuration
      @$.configuration.postgresql_orm = @$.configuration.mysql_orm = newValue
    @$.sqlConfigPath = switch newValue
      when 'activerecord', 'sequel', 'datamapper' then 'config/database.yml'

  _onMongodbOrmChange: (newValue) ->
    @$.mongodbConfigPath = switch newValue
      when 'mongoid' then 'config/mongoid.yml'
      when 'mongomapper' then 'config/mongo.yml'

  _onDatabasesChange: (newValue) ->
    if @$.configuration and @$.configuration.databases
      @$.activeObjects = @$.configuration.databases
