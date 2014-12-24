angular.module('app.rubyops').classy.controller
  name: 'ConfigurationController'
  inject: ['$scope']
  init: ->
    @$.osList = [
      { box: 'ubuntu/trusty64', name: 'Ubuntu Trusty 14.04' }
    ]
    @$.coresList = [ 1, 2, 3, 4 ]
    @$.vm =
      name: 'myapp'
      os: @$.osList[0]
      memory: 700
      cores: 1
  generate: ->
    console.log 'yeah'
