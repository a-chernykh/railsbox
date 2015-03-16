angular
  .module('app.railsbox')
  .directive 'notification', ->
    restrict: 'E'
    templateUrl: 'notification.html'
    link: (scope, element, attrs) ->
      scope.$watch 'notification.message', (newVal) -> $('.fork-me img').toggle(!newVal)
      scope.close = -> scope.notification.message = null
