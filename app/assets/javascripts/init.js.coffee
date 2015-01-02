$ ->
  $('a[href=#]').click (e) ->
    e.preventDefault()
  
  $('[data-toggle="tooltip"]').tooltip()
  $('input[data-copies-itself]').focus ->
    @select()
