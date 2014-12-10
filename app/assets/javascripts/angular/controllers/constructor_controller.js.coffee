angular.module('app.constructor').classy.controller
  name: 'ConstructorController'
  inject: ['$scope']
  init: ->
    @$.sortableOptions = {}
    @$.items = [{text: 'Item #1'}, {text: 'Item #2'}]
