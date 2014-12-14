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
        console.log scope.items
    @$.items = []
    @$.items.push new Widget 'file', { path: '/home/jlor/app', owner: 'jlor' }
    @$.items.push new Widget 'file', { path: '/home/jlor/app', owner: 'jlor' }
