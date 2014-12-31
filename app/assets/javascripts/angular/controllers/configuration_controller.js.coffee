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
      ports: [
        { guest: 80,  host: 8080 },
        { guest: 443, host: 8081 }
      ]

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
      user: 'vagrant'

    @$.allObjects = []
    @$.activeObjects = []

    @$.delayed_job =
      command: 'script/delayed_job run'

    @$.sidekiq =
      command: 'sidekiq'

    @$.isActive = (obj) ->
      obj in @activeObjects

    @$.allActive = ->
      @activeObjects.length == @allObjects.length

    @$.add = (obj) ->
      @activeObjects.push obj

    @$.delete = (obj) ->
      @activeObjects = @activeObjects.filter (curObj) -> curObj isnt obj

  watch:
    'vm.name': '_onVmNameChanged'

  _onVmNameChanged: (newValue, oldValue) ->
    if @$.delayed_job.app_name is undefined || @$.delayed_job.app_name == "#{oldValue}-delayed_job"
      @$.delayed_job.app_name = "#{newValue}-delayed_job"
    if @$.sidekiq.app_name is undefined || @$.sidekiq.app_name == "#{oldValue}-sidekiq"
      @$.sidekiq.app_name = "#{newValue}-sidekiq"
    if @$.db.name is undefined || @$.db.name == oldValue
      @$.db.name = newValue
