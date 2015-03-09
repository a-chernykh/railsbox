angular.module('app.railsbox').controller 'BackgroundJobsController', ['$scope', ($scope) ->
  $scope.allObjects = [
    { id: 'delayed_job', name: 'delayed_job' },
    { id: 'sidekiq',     name: 'sidekiq' },
    { id: 'resque',      name: 'resque' },
  ]
  $scope.activeObjects = []

  $scope.$watch 'configuration.rails_version', (newValue) ->
    if newValue
      $scope.configuration.delayed_job_command = switch newValue.version
        when '4' then 'bin/delayed_job run'
        else 'script/delayed_job run'

  $scope.$watch 'configuration.background_jobs', (newValue) ->
    if $scope.configuration and $scope.configuration.background_jobs
      $scope.activeObjects = $scope.configuration.background_jobs
]
