# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

# dynamic select menu for new job posts
  types_1 = $('#post_service_type_id').html()
  $(document).ready ->
    currentLocation = window.location
    if currentLocation.pathname == "/posts/new" or currentLocation.pathname == "/posts/"+post_id+"/edit"
      category = $('#post_service_category_id :selected').text()
      options = $(types_1).filter("optgroup[label='#{category}']").html()
      if options
        $('#post_service_type_id').html(options)
        $('#post_service_type_id').selectpicker('refresh')
      else
        $('#post_service_type_id').empty()
        $('#post_service_type_id').selectpicker('refresh')
  $('#post_service_category_id').change -> 
    category = $('#post_service_category_id :selected').text()
    options = $(types_1).filter("optgroup[label='#{category}']").html()
    if options
      $('#post_service_type_id').html(options)
      $('#post_service_type_id').selectpicker('refresh')
    else
      $('#post_service_type_id').empty()
      $('#post_service_type_id').selectpicker('refresh')



#dynamic select menu for filters
  currentLocation = window.location
  if currentLocation.pathname == "/posts"
    types_2 = $('#post_type_id').html()
    #show up the previously selected type
    $(document).ready ->
      category = $('#post_category_id :selected').text()
      options = $(types_2).filter("optgroup[label='#{category}']").html()
      if options
        $('#post_type_id').html(options)
        $('#post_type_id').selectpicker('refresh')
      else
        $('#post_type_id').empty()
        $('#post_type_id').selectpicker('refresh')
    $('#post_category_id').change -> 
      categories = $('#post_category_id :selected')
      total = $('#post_type_id')
      options = null
      #if categories.length > 0
        #options = "<option>All types</option>"
      i = 0
      while i < categories.length
        category = categories[i].text
        option = $(types_2).filter("optgroup[label='#{category}']").html()
        options = options + option
        i++
      if options
        $('#post_type_id').html(options)
        $('#post_type_id').selectpicker('refresh')
        $('#post_type_id').parent().show()
      else
        $('#post_type_id').empty()
        $('#post_type_id').selectpicker('refresh')







#auto complete google map API javascripts
  initializeFormMap = ->
    map = new (google.maps.Map)(document.getElementById('post_form_map'),
      center:
        lat: 43.6629
        lng: -79.3957
      zoom: 11)
    if post_address != ""
      geocoder = new (google.maps.Geocoder)
      geocoder.geocode { 'address': post_address }, (results, status) ->
        if status == google.maps.GeocoderStatus.OK
          map.setCenter results[0].geometry.location
          map.setZoom 17
          marker = new (google.maps.Marker)(
            map: map
            position: results[0].geometry.location)
    input = document.getElementById('post_work_address')
    autocomplete = new (google.maps.places.Autocomplete)(input)
    autocomplete.bindTo 'bounds', map
    infowindow = new (google.maps.InfoWindow)
    infowindowContent = document.getElementById('infowindow-content')
    infowindow.setContent infowindowContent
    marker = new (google.maps.Marker)(
      map: map
      anchorPoint: new (google.maps.Point)(0, -29))
    autocomplete.addListener 'place_changed', ->
      infowindow.close()
      marker.setVisible false
      place = autocomplete.getPlace()
      if !place.geometry
        # User entered the name of a Place that was not suggested and
        # pressed the Enter key, or the Place Details request failed.
        window.alert 'No details available for input: \'' + place.name + '\''
        return
      # If the place has a geometry, then present it on a map.
      if place.geometry.viewport
        map.fitBounds place.geometry.viewport
      else
        map.setCenter place.geometry.location
        map.setZoom 17
        # Why 17? Because it looks good.
      marker.setPosition place.geometry.location
      marker.setVisible true
      address = ''
      if place.address_components
        address = [
          place.address_components[0] and place.address_components[0].short_name or ''
          place.address_components[1] and place.address_components[1].short_name or ''
          place.address_components[2] and place.address_components[2].short_name or ''
        ].join(' ')
      infowindowContent.children['place-icon'].src = place.icon
      infowindowContent.children['place-name'].textContent = place.name
      infowindowContent.children['place-address'].textContent = address
      infowindow.open map, marker

  $(document).ready ->
    #currentLocation = window.location
    #if currentLocation.pathname == "/posts/new" or currentLocation.pathname == "/posts/"+post_id+"/edit"
    initializeFormMap()







#google map API for showing up selected address javascripts
  initializeShowMap = ->
    latlng = new (google.maps.LatLng)(43.6629, -79.3957)
    mapOptions = 
      zoom: 17
      center: latlng
    map = new (google.maps.Map)(document.getElementById('post_show_map'), mapOptions)
    geocoder = new (google.maps.Geocoder)
    infowindow = new (google.maps.InfoWindow)
    geocoder.geocode { 'address': show_address }, (results, status) ->
      if status == google.maps.GeocoderStatus.OK
        # Center map on location
        map.setCenter results[0].geometry.location
        # Add marker on location
        marker = new (google.maps.Marker)(
          map: map
          position: results[0].geometry.location)
        google.maps.event.addListener marker, 'click', ->
          post_information = "<h5>Work Location: " + show_address + "</h5>\n"
          infowindow.setContent post_information
          infowindow.open map, marker

  $(document).ready ->
    currentLocation = window.location
    if currentLocation.pathname == "/posts/"+post_id
      initializeShowMap()







#google map API for showing up all address javascripts
  initializeAllMap = ->
    latlng = new (google.maps.LatLng)(43.6629, -79.3957)
    mapOptions = 
      zoom: 13
      center: latlng
    map = new (google.maps.Map)(document.getElementById('post_all_map'), mapOptions)
    geocoder = new (google.maps.Geocoder)
    bound = new (google.maps.LatLngBounds)
    infowindow = new (google.maps.InfoWindow)
    i = 0
    while i < all_posts.length
      post = all_posts[i]
      post_route = all_posts_routes[i]
      geocoder.geocode { 'address': post.work_address }, displayMarkerInformation(post, post_route, map, bound, infowindow)
      i++
    displayCurrentLocation(map)

  displayMarkerInformation = (post, post_route, map, bound, infowindow) ->
    (results, status) ->
      if status == google.maps.GeocoderStatus.OK
        marker = new (google.maps.Marker)(
          map: map
          position: results[0].geometry.location)
        google.maps.event.addListener marker, 'click', ->
          post_information = "<h5>" + post.title + "</h5>\n" + "<p><strong>Description: </strong>" + post.description + "</p>" + "<p><strong>Address: </strong>" + post.work_address + "</p>" + "<a href=\"" + post_route + "\">View Job Post Deatils</a>";
          infowindow.setContent post_information
          infowindow.open map, marker
        #bound map to cover all the posts in the map
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
    if currentLocation.pathname == "/posts"
      initializeAllMap()



#ratings
  $(document).ready ->
    $('[type*="radio"]').change ->
      test = @id
      string = test.split(':')
      me = undefined
      me = undefined
      me = $(this)
      id_result = 'email_field' + string[1]
      document.getElementById(id_result).value = me.attr('value')
      return
    return
