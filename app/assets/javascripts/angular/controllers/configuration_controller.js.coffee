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
      memory: 1024
      swap: 1024
      cores: 1
      ports: [
        { guest: 80,  host: 8080 },
        { guest: 443, host: 8081 }
      ]

    @$.rubyInstalls =
      package:
        label: 'System package'
        # https://www.brightbox.com/docs/ruby/ubuntu/
        rubies: [ { version: 'ruby1.8',   label: '1.8' },
                  { version: 'ruby1.9.1', label: '1.9.1' },
                  { version: 'ruby2.1',   label: '2.1', default: true },
                  { version: 'ruby2.2',   label: '2.2 (beta)' } ]
      rvm:
        label: 'RVM'
        rubies: [ 
                  { version: '1.8.6',    label: '1.8.6' },
                  { version: '1.8.7',    label: '1.8.7' },
                  { version: '1.9.1',    label: '1.9.1' },
                  { version: '1.9.2',    label: '1.9.2' },
                  { version: '1.9.3',    label: '1.9.3' },
                  { version: '2.0.0',    label: '2.0.0' },
                  { version: '2.1.1',    label: '2.1.1' },
                  { version: '2.1.2',    label: '2.1.2' },
                  { version: '2.1.3',    label: '2.1.3' },
                  { version: '2.1.4',    label: '2.1.4' },
                  { version: '2.1.5',    label: '2.1.5', default: true },
                  { version: '2.2.0',    label: '2.2.0' },
                  { version: '2.2-head', label: '2.2-head' },
                ]

    @$.railsVersions = [
      { version: '2',   label: 'rails 2.0+' },
      { version: '3', label: 'rails 3.0+' },
      { version: '4',   label: 'rails 4.0+' }
    ]

    @$.app =
      serverName: 'localhost'
      railsVersion: @$.railsVersions[2]
      rubyInstall: 'rvm'
      environmentFile: '/vagrant/.envrc'

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
    'app.rubyInstall': '_onRubyInstallChanged'

  _onVmNameChanged: (newValue, oldValue) ->
    if @$.delayed_job.app_name is undefined || @$.delayed_job.app_name == "#{oldValue}-delayed_job"
      @$.delayed_job.app_name = "#{newValue}-delayed_job"
    if @$.sidekiq.app_name is undefined || @$.sidekiq.app_name == "#{oldValue}-sidekiq"
      @$.sidekiq.app_name = "#{newValue}-sidekiq"
    if @$.db.name is undefined || @$.db.name == oldValue
      @$.db.name = newValue

  _onRubyInstallChanged: (newValue) ->
    if newValue isnt undefined
      @$.app.rubyVersion = (version for version in @$.rubyInstalls[newValue].rubies when version.default == true)[0]
