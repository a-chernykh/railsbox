angular
  .module('app.railsbox')
  .controller 'EnvironmentsController', ($scope, ENVIRONMENTS) ->
    $scope.allObjects = ENVIRONMENTS
    $scope.bindToConfiguration 'environments'

    $scope.isVirtualBox = -> @configuration[@environment].target == 'virtualbox'
    $scope.isServer = -> @configuration[@environment].target == 'server'
