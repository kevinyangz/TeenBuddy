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
  x = document.querySelectorAll('.teenager_rating .stars-inner')
  i = undefined
  i = 0
  while i < x.length
    rate = x[i].id
    starPercentage = rate / 5 * 100
    starPercentageRounded = Math.round(starPercentage / 10) * 10 + '%'
    x[i].style.width = starPercentageRounded
    i++
  return

$ ->
  # Initializes and creates emoji set from sprite sheet
  window.emojiPicker = new EmojiPicker(
    emojiable_selector: '[data-emojiable=true]'
    assetsPath: 'http://onesignal.github.io/emoji-picker/lib/img/'
    popupButtonClasses: 'fa fa-smile-o')
  window.emojiPicker.discover()
  return




jQuery ->
  #google map API for showing up all address javascripts
  initializeAllMap = ->
    latlng = new (google.maps.LatLng)(43.6629, -79.3957)
    mapOptions = 
      zoom: 13
      center: latlng
    map = new (google.maps.Map)(document.getElementById('teenager_all_map'), mapOptions)
    geocoder = new (google.maps.Geocoder)
    bound = new (google.maps.LatLngBounds)
    infowindow = new (google.maps.InfoWindow)
    i = 0
    while i < all_teenagers.length
      teenager = all_teenagers[i]
      geocoder.geocode { 'address': teenager.home_address }, displayMarkerInformation(teenager, map, bound, infowindow)
      i++
    displayCurrentLocation(map)

  displayMarkerInformation = (teenager, map, bound, infowindow) ->
    (results, status) ->
      if status == google.maps.GeocoderStatus.OK
        marker = new (google.maps.Marker)(
          map: map
          position: results[0].geometry.location)
        google.maps.event.addListener marker, 'click', ->
          teenager_information = "<h5>" + teenager.fname + " " + teenager.lname + "</h5>\n" + "<p><strong>Address: </strong>" + teenager.home_address + "</p>"
          infowindow.setContent teenager_information
          infowindow.open map, marker
        bound.extend marker.getPosition()
        map.fitBounds bound

  displayCurrentLocation = (map, infowindow) -> 
    infoWindow = new (google.maps.InfoWindow)
    # Try HTML5 geolocation.
    if navigator.geolocation
      navigator.geolocation.getCurrentPosition ((position) ->
        pos = 
          lat: position.coords.latitude
          lng: position.coords.longitude
        image = "assets/img/location.png"
        marker = new (google.maps.Marker)(
          map: map
          animation: google.maps.Animation.DROP,
          icon: image,
          zIndex: google.maps.Marker.MAX_ZINDEX + 1,
          position: pos)
        infoWindow.setPosition pos
        infoWindow.setContent "<strong>You are here!</strong>"
        infoWindow.open map, marker
        map.setCenter pos
        return
      ), ->
        handleLocationError true, infoWindow, map.getCenter()
        return
    else
      # Browser doesn't support Geolocation
      handleLocationError false, infoWindow, map.getCenter()
 
  $(document).ready ->
    currentLocation = window.location
    if currentLocation.pathname == "/teenagers"
      initializeAllMap()