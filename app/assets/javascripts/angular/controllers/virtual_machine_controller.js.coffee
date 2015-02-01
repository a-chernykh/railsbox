angular.module('app.railsbox').classy.controller
  name: 'VirtualMachineController'
  inject: ['$scope']

  addPort: ->
    @$.configuration[@$.environment].vm_ports.push { guest: @$.newGuestPort, host: @$.newHostPort }
    @$.newGuestPort = null
    @$.newHostPort = null

  deletePort: (index) ->
    @$.configuration[@$.environment].vm_ports.splice index, 1
