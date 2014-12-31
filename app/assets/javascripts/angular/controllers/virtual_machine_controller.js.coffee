angular.module('app.rubyops').classy.controller
  name: 'VirtualMachineController'
  inject: ['$scope']

  addPort: ->
    @$.vm.ports.push { guest: @$.newGuestPort, host: @$.newHostPort }
    @$.newGuestPort = null
    @$.newHostPort = null
