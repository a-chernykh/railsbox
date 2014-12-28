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

    @$.rubyVersions = [
      { version: '2.1.2' }
    ]
    @$.app =
      serverName: 'localhost'
      rubyVersion: @$.rubyVersions[0]

    @$.db =
      name: defaultAppName
      user: defaultAppName

  applicationUrl: -> "http://localhost:#{@$.vm.httpForwardPort}"
