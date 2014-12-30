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

    @$.app =
      serverName: 'localhost'
      rubyVersion: @$.rubyVersions[2]

    @$.db =
      name: defaultAppName
      user: 'vagrant'

  applicationHttpUrl: -> "http://localhost:#{@$.vm.httpForwardPort}"
  applicationHttpsUrl: -> "https://localhost:#{@$.vm.httpsForwardPort}"
  installDbToggle: ->
