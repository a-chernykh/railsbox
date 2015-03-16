angular
  .module('app.railsbox')
  .factory 'notifier', ['$rootScope', ($rootScope)  ->
    error: (message) ->
      $rootScope.notification =
        class: 'alert-danger'
        message: message

    success: (message) ->
      $rootScope.notification =
        class: 'alert-success'
        message: message
]
