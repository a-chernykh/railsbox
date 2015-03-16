angular
  .module('app.railsbox')
  .controller 'GemfileAnalyzerController', [ '$rootScope', '$scope', '$upload', 'notifier', ($rootScope, $scope, $upload, notifier) ->

    upload = (gemfile) ->
      if gemfile
        $upload.upload({
          url: '/configurations/for_gemfile',
          file: gemfile,
          fileFormDataName: 'gemfile'
        }).success((data, status, headers, config) ->
          $scope.loadConfiguration(data)
          notifier.success 'Gemfile was parsed. Form was pre-populated.'
        ).error((data, status) ->
          notifier.error data.error
        )

    $scope.$watch 'gemfile', -> upload($scope.gemfile)
]
