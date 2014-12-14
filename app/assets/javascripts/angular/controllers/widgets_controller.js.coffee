angular.module('app.constructor').classy.controller
  name: 'WidgetsController'
  inject: ['$scope']
  init: ->
    scope = @$
    setAllWidgets = ->
      allWidgets = 
        'Filesystem': [
          new Widget('directory', 'Create new directory', [
            { 'label': 'Path', 'name': 'path', 'type': 'path' },
            { 'label': 'Owner', 'name': 'owner', 'type': 'user' },
            { 'label': 'Mode', 'name': 'mode', 'type': 'fmode' }
          ]),
          new Widget('symlink', 'Create symbolic link', [
            { 'label': 'Source', 'name': 'source', 'type': 'path' },
            { 'label': 'Destination', 'name': 'dest', 'type': 'path' }
          ]),
          new Widget('file_attributes', 'Change file attributes', [
            { 'label': 'Path', 'name': 'file', 'type': 'path' },
            { 'label': 'Owner', 'name': 'owner', 'type': 'user' },
            { 'label': 'Mode', 'name': 'mode', 'type': 'fmode' },
            { 'label': 'Recursive', 'name': 'recurse', 'type': 'boolean' }
          ])
        ]
      scope.widgets = jQuery.extend(true, {}, allWidgets);
    @$.sortableOptions =
      connectWith: '.playbook'
      remove: -> setAllWidgets()
    setAllWidgets()
