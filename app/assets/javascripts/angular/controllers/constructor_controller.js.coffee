class Item
  constructor: (@name, @args) ->
  template: ->
    "#{@name}.html"

angular.module('app.constructor').classy.controller
  name: 'ConstructorController'
  inject: ['$scope']
  init: ->
    @$.sortableOptions = {}
    @$.items = []
    @$.items.push new Item 'file', { path: '/home/jlor/app', owner: 'jlor' }
    @$.items.push new Item 'file', { path: '/home/jlor/app', owner: 'jlor' }
