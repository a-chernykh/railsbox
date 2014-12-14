window.Widget = class Widget
  constructor: (@name, @label, @args) ->
  template: ->
    "#{@name}.html"
