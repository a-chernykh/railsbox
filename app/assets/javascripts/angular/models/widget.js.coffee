class WidgetArg
  constructor: (@widget, @options) ->
    @name = @options.name
    @type = @options.type
    @label = @options.label
    @value = @options.default
  htmlId: ->
    [@name, @widget.id].join('-')
  template: ->
    switch @type
      when 'dropdown' then 'argument_dropdown.html'
      when 'boolean' then 'argument_boolean.html'
      else 'argument_text.html'

window.Widget = class Widget
  constructor: (@name, @label, args) ->
    @args = []
    @args.push new WidgetArg(@, arg) for arg in args

  template: -> 'default.html'
