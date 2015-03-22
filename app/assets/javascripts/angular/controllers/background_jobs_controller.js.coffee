angular
  .module('app.railsbox')
  .controller 'BackgroundJobsController', ($scope, BACKGROUND_JOBS) ->
    $scope.allObjects = BACKGROUND_JOBS
    $scope.bindToConfiguration 'background_jobs'

    $scope.$watch 'configuration.rails_version', (newValue) ->
      if newValue
        $scope.configuration.delayed_job_command = switch newValue.version
          when '4' then 'bin/delayed_job run'
          else 'script/delayed_job run'
