angular.module('app.rubyops').classy.controller
  name: 'BackgroundJobsController'
  inject: ['$scope']

  init: ->
    @$.allObjects = [
      { id: 'delayed_job', name: 'delayed_job' },
      { id: 'sidekiq',     name: 'sidekiq' },
    ]
    @$.activeObjects = []

  watch:
    'configuration.rails_version': '_onRailsVersionChange'
    'configuration.background_jobs': '_onBackgroundJobsChange'

  _onRailsVersionChange: (newValue) ->
    if newValue
      @$.configuration.delayed_job_command = switch newValue.version
        when '4' then 'bin/delayed_job run'
        else 'script/delayed_job run'

  _onBackgroundJobsChange: (newValue) ->
    if @$.configuration and @$.configuration.background_jobs
      @$.activeObjects = @$.configuration.background_jobs
