angular.module('app.constructor').directive 'item', ->
  restrict: 'E'
  scope:
    item: '=item'
  template: '<div ng-include="item.template()"></div>'
