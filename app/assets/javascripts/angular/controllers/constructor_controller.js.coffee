angular.module('app.constructor').classy.controller
  name: 'ConstructorController'
  inject: ['$scope']
  init: ->
    id = 1
    scope = @$
    @$.sortableOptions =
      axis: 'y'
      receive: (event, ui) ->
        ui.item.sortable.model.id = id
        id = id + 1
    @$.items = []
