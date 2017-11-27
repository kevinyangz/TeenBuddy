# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

# dynamic select menu for new job posts
  types_1 = $('#post_service_type_id').html()
  $(document).ready ->
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





# dynamic checkboxes for filters
  $(":checkbox[name='service_type']").parent().hide()
  $(":checkbox[id='service_type_all']").parent().show()
  c = document.getElementById('service_category_babysitting')
  $(":checkbox[name='service_category'][id!='service_category_all']").change ->
    categories_check = document.getElementsByName('service_category')
    console.log(categories_check)
    i = 0

    while i < categories_check.length
      if categories_check[i].checked
        # uncheck the all_types field
        if i != 0
          categories_check[0].checked = false
        # do not uncheck the other types fileds because otherwise user cannot select

        if i == 0
          $(":checkbox[name='service_type'][id!='service_type_all']").parent().hide()
        else if categories_check[0].checked == false
          $(":checkbox[value='#{categories_check[i].value}'][name='service_type']").parent().show()

      else if not categories_check[i].checked
        $(":checkbox[value='#{categories_check[i].value}'][name='service_type']").parent().hide()

      i++

# track all_types checkbox only, remove all the checked boxes
  $(":checkbox[id='service_category_all']").change ->
    category_all_types = document.getElementById('service_category_all')
    categories_check = document.getElementsByName('service_category')
    if category_all_types.checked
      i = 0
      while i < categories_check.length
        if categories_check[i].id != 'service_category_all'
          $(":checkbox[id=#{categories_check[i].id}]").prop 'checked', false
          $(":checkbox[value='#{categories_check[i].value}'][name='service_type']").parent().hide()
        i++

    # clear the checkboxes of service types
    categories_check = document.getElementsByName('service_category')
    i = 0
    while i < categories_check.length
      if categories_check[i].id != 'service_category_all' and categories_check[i].checked == false
        $(":checkbox[value='#{categories_check[i].value}'][name='service_type']").prop 'checked', false
      else if categories_check[i].id == 'service_category_all' and categories_check[i].checked == true
        $(":checkbox[id='service_type_all']").prop 'checked', true
      i++

  $(":checkbox").parent().hide()




#auto complete google map API javascripts
  initializeFormMap = ->
    map = new (google.maps.Map)(document.getElementById('post_form_map'),
      center:
        lat: 43.70011
        lng: -79.4163
      zoom: 10)
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

  google.maps.event.addDomListener window, 'load', initializeFormMap




#google map API for showing up selected address javascripts
  initializeShowMap = ->
    latlng = new (google.maps.LatLng)(43.70011, -79.4163)
    mapOptions = 
      zoom: 17
      center: latlng
    map = new (google.maps.Map)(document.getElementById('post_show_map'), mapOptions)
    geocoder = new (google.maps.Geocoder)
    geocoder.geocode { 'address': address }, (results, status) ->
      if status == google.maps.GeocoderStatus.OK
        # Center map on location
        map.setCenter results[0].geometry.location
        # Add marker on location
        marker = new (google.maps.Marker)(
          map: map
          position: results[0].geometry.location)
      else
        alert 'Geocode was not successful for the following reason: ' + status
    return

  google.maps.event.addDomListener window, 'load', initializeShowMap



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
