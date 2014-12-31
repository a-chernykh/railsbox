angular.module('app.rubyops').classy.controller
  name: 'VirtualMachineController'
  inject: ['$scope']
  init: ->
    @$.packages =
      graphics:
        label: 'Graphics kit'
        packages: [ 'imagemagick' ]
        selected: true
      qt:
        label: 'QT kit'
        packages: [ 'qt5-default', 'libqt5webkit5-dev' ]
        selected: true

  addPort: ->
    @$.vm.ports.push { guest: @$.newGuestPort, host: @$.newHostPort }
    @$.newGuestPort = null
    @$.newHostPort = null

  deletePort: (index) ->
    @$.vm.ports.splice index, 1
