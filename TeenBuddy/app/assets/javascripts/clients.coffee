# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  initialize = ->
    input = document.getElementById('client_home_address')
    autocomplete = new (google.maps.places.Autocomplete)(input)

  google.maps.event.addDomListener window, 'load', initialize

  $(document).ready ->
  x = document.querySelectorAll('.hotel_a .stars-inner')
  i = undefined
  i = 0
  while i < x.length
    rate = x[i].id
    starPercentage = rate / 5 * 100
    starPercentageRounded = Math.round(starPercentage / 10) * 10 + '%'
    x[i].style.width = starPercentageRounded
    i++
  return