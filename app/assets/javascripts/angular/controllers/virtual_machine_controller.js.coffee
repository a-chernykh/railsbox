angular.module('app.rubyops').classy.controller
  name: 'VirtualMachineController'
  inject: ['$scope']

  addPort: ->
    @$.configuration.vm_ports.push { guest: @$.newGuestPort, host: @$.newHostPort }
    @$.newGuestPort = null
    @$.newHostPort = null

  deletePort: (index) ->
    @$.configuration.vm_ports.splice index, 1
