angular.module('app.rubyops').classy.controller
  name: 'VirtualMachineController'
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

  addPort: ->
    @$.vm.ports.push { guest: @$.newGuestPort, host: @$.newHostPort }
    @$.newGuestPort = null
    @$.newHostPort = null
