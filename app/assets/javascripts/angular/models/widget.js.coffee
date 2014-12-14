class WidgetArg
  constructor: (@widget, @label, @name, @type) ->
  htmlId: ->
    [@name, @widget.id].join('-')
  htmlType: ->
    switch @type
      when 'boolean' then 'checkbox'
      else 'text'
  htmlClass: ->
    switch @type
      when 'boolean' then ''
      else 'form-control'

window.Widget = class Widget
  constructor: (@name, @label, args) ->
    @args = []
    @args.push new WidgetArg(@, arg.label, arg.name, arg.type) for arg in args

  template: -> 'default.html'
