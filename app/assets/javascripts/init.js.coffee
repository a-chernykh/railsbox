$ ->
  $('a[href=#]').click (e) ->
    e.preventDefault()
  
  $('[data-toggle="tooltip"]').tooltip()
