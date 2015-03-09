angular.module('app.railsbox').controller 'EnvironmentsController', [ '$scope', ($scope) ->
  $scope.allObjects = [
    { id: 'development' },
    { id: 'staging' },
    { id: 'production' },
  ]
  $scope.activeObjects = []

  $scope.isVirtualBox = -> @configuration[@environment].target == 'virtualbox'
  $scope.isServer = -> @configuration[@environment].target == 'server'

  $scope.$watch 'configuration.environments', (newValue) ->
    if $scope.configuration and $scope.configuration.environments
      $scope.activeObjects = $scope.configuration.environments
]
