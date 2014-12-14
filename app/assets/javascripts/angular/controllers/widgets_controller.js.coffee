angular.module('app.constructor').classy.controller
  name: 'WidgetsController'
  inject: ['$scope']
  init: ->
    scope = @$
    setAllWidgets = ->
      allWidgets = 
        'Filesystem': [
          new Widget('file', 'Create new directory', { path: '/home/jlor/app', owner: 'jlor' }),
          new Widget('file', 'Create symbolic link', { path: '/home/jlor/app', owner: 'jlor' }),
          new Widget('file', 'Change file attributes', { path: '/home/jlor/app', owner: 'jlor'})
        ]
      scope.widgets = jQuery.extend(true, {}, allWidgets);
    @$.sortableOptions =
      connectWith: '.playbook'
      remove: -> setAllWidgets()
    setAllWidgets()
