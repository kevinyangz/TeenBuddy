# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  # dynamic select menu for new job posts
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


  # track check box of service_catories
  $(":checkbox[name='service_type']").parent().hide()
  $(":checkbox[id='service_type_all']").parent().show()

  $(":checkbox[name='service_category'][id!='service_category_all']").change ->
    categories_check = document.getElementsByName('service_category')
    i = 0

    while i < categories_check.length
      if categories_check[i].checked
        # uncheck the all_types field
        if i != 0
          categories_check[0].checked = false
        # do not uncheck the other types fileds because otherwise user cannot select

        if i == 0
          $(":checkbox[name='service_type']").parent().hide()
          $(":checkbox[id='service_type_all']").parent().show()
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
      i = 1
      while i < categories_check.length
        $(":checkbox[id=#{categories_check[i].id}]").prop 'checked', false
        $(":checkbox[value='#{categories_check[i].value}'][name='service_type']").parent().hide()
        i++

