# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# This example requires the Places library. Include the libraries=places
# parameter when you first load the API. For example:
# <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">

jQuery ->
placeSearch = undefined
autocomplete = undefined
componentForm = postal_code: 'short_name'

initAutocomplete = ->
  # Create the autocomplete object, restricting the search to geographical
  # location types.
  autocomplete = new (google.maps.places.Autocomplete)(document.getElementById('teenager_home_address'), types: [ 'geocode' ])
  # When the user selects an address from the dropdown, populate the address
  # fields in the form.
  autocomplete.addListener 'place_changed', ->
    place = autocomplete.getPlace()
    for component of componentForm
      document.getElementById(component).value = ''
      document.getElementById(component).disabled = false
    # Get each component of the address from the place details
    # and fill the corresponding field on the form.
    i = 0
    while i < place.address_components.length
      addressType = place.address_components[i].types[0]
      if componentForm[addressType]
        val = place.address_components[i][componentForm[addressType]]
        document.getElementById(addressType).value = val
      i++
    return
  return

google.maps.event.addDomListener window, 'load', initAutocomplete

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
# generated by js2coffee 2.2.0