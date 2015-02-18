angular.module('app.railsbox').classy.controller
  name: 'EnvironmentsController'
  inject: ['$scope']

  init: ->
    @$.allObjects = [
      { id: 'development' },
      { id: 'staging' },
      { id: 'production' },
    ]
    @$.activeObjects = []

    @$.isVirtualBox = -> @configuration[@environment].target == 'virtualbox'
    @$.isServer = -> @configuration[@environment].target == 'server'

  watch:
    'configuration.environments': '_onEnvironmentsChange'

  _onEnvironmentsChange: (newValue) ->
    if @$.configuration and @$.configuration.environments
      @$.activeObjects = @$.configuration.environments
