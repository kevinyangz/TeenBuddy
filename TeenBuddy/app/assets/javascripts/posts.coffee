# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  types = $('#post_service_type_id').html()
  $('#postservice_category_id').change -> 
    console.log("gggggg")
    category = $('#post_service_category_id :selected').text()
    console.log(category)
    options = $(types).filter("optgroup[label='#{category}']").html()
    if options
      $('#service_type_id').html(options)
    else
      $('#service_type_id').empty()