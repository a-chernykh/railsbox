angular.module('app.rubyops').classy.controller
  name: 'ConfigurationController'
  inject: ['$scope']

  init: ->
    defaultAppName = 'myapp'

    @$.osList = [
      { box: 'ubuntu/trusty64', name: 'Ubuntu Trusty 14.04' }
    ]
    @$.coresList = [ 1, 2, 3, 4 ]
    @$.vm =
      name: defaultAppName
      os: @$.osList[0]
      memory: 700
      cores: 1
      httpForwardPort: 8080
      httpsForwardPort: 8081

    # https://www.brightbox.com/docs/ruby/ubuntu/
    @$.rubyVersions = [
      { package: 'ruby1.8',   label: '1.8' },
      { package: 'ruby1.9.1', label: '1.9.1' },
      { package: 'ruby2.1',   label: '2.1' },
      { package: 'ruby2.2',   label: '2.2 (beta)' }
    ]

    @$.railsVersions = [
      { version: '2',   label: 'rails 2.0+' },
      { version: '3', label: 'rails 3.0+' },
      { version: '4',   label: 'rails 4.0+' }
    ]

    @$.app =
      serverName: 'localhost'
      rubyVersion: @$.rubyVersions[2]
      railsVersion: @$.railsVersions[2]

    @$.db =
      name: defaultAppName
      user: 'vagrant'

    @$.sqlOrm = 'activerecord'
    @$.mongodbOrm = 'mongoid'
    @$.redisOrm = 'redis-rb'

    @$.delayed_job =
      app_name: "#{defaultAppName}-delayed_job"
      command: 'script/delayed_job run'

  watch:
    'sqlOrm': '_onSqlOrmChange'
    'mongodbOrm': '_onMongodbOrmChange'
    'app.railsVersion': '_onRailsVersionChange'

  applicationHttpUrl: -> "http://localhost:#{@$.vm.httpForwardPort}"
  applicationHttpsUrl: -> "https://localhost:#{@$.vm.httpsForwardPort}"
  installDbToggle: ->

  _onSqlOrmChange: (newValue) ->
    @$.sqlConfigPath = switch newValue
      when 'activerecord', 'sequel', 'datamapper' then 'config/database.yml'

  _onMongodbOrmChange: (newValue) ->
    @$.mongodbConfigPath = switch newValue
      when 'mongoid' then 'config/mongoid.yml'
      when 'mongomapper' then 'config/mongo.yml'

  _onRailsVersionChange: (newValue) ->
    if newValue
      @$.delayed_job.command = switch newValue.version
        when '4' then 'bin/delayed_job run'
        else 'script/delayed_job run'
