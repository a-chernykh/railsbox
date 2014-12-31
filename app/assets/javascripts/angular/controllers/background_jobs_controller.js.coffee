angular.module('app.rubyops').classy.controller
  name: 'BackgroundJobsController'
  inject: ['$scope']

  init: ->
    @$.allObjects = [
      { id: 'delayed_job', name: 'delayed_job' }
    ]
    @$.activeObjects = []

  watch:
    'app.railsVersion': '_onRailsVersionChange'

  _onRailsVersionChange: (newValue) ->
    if newValue
      @$.delayed_job.command = switch newValue.version
        when '4' then 'bin/delayed_job run'
        else 'script/delayed_job run'
