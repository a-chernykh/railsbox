angular.module('app.railsbox').controller 'VirtualMachineController', [ '$scope', ($scope) ->
  $scope.addPort = ->
    $scope.configuration[$scope.environment].vm_ports.push { guest: $scope.newGuestPort, host: $scope.newHostPort }
    $scope.newGuestPort = null
    $scope.newHostPort = null

  $scope.deletePort = (index) ->
    $scope.configuration[$scope.environment].vm_ports.splice index, 1
]
