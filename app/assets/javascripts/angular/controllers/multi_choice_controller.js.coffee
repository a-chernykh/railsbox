angular.module('app.railsbox').classy.controller
  name: 'MultiChoiceController'
  inject: ['$scope']

  init: ->
    @$.allObjects = []
    @$.activeObjects = []

    @$.isActive = (obj) ->
      obj in @activeObjects

    @$.allActive = ->
      @activeObjects.length == @allObjects.length

    @$.add = (obj) ->
      @activeObjects.push obj

    @$.delete = (obj) ->
      index = @activeObjects.indexOf(obj)
      @activeObjects.splice(index, 1) unless index == -1
