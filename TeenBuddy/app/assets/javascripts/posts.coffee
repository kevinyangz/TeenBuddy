# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#post_service_type_id').parent().hide()
  types = $('#post_service_type_id').html()
  $('#post_service_category_id').change -> 
    category = $('#post_service_category_id :selected').text()
    options = $(types).filter("optgroup[label='#{category}']").html()
    if options
      #below line changes html but the new html is not rendered, need help
      $('#post_service_type_id').html(options)
      $('#post_service_type_id').selectpicker('refresh')
      $('#post_service_type_id').parent().show()
    else
      $('#post_service_type_id').parent().hide()