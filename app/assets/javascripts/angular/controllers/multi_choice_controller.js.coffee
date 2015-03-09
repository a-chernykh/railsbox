angular.module('app.railsbox').controller 'MultiChoiceController', [ '$scope', ($scope) ->
  $scope.allObjects = []
  $scope.activeObjects = []

  $scope.isActive = (obj) ->
    obj in @activeObjects

  $scope.allActive = ->
    @activeObjects.length == @allObjects.length

  $scope.add = (obj) ->
    @activeObjects.push obj

  $scope.delete = (obj) ->
    index = @activeObjects.indexOf(obj)
    @activeObjects.splice(index, 1) unless index == -1
]
