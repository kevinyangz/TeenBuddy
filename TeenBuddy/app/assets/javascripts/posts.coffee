# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  # dynamic select menu for new job posts
  $('#post_service_type_id').parent().hide()
  types_1 = $('#post_service_type_id').html()
  $('#post_service_category_id').change -> 
    category = $('#post_service_category_id :selected').text()
    options = $(types_1).filter("optgroup[label='#{category}']").html()
    if options
      #below line changes html but the new html is not rendered, need help
      $('#post_service_type_id').html(options)
      $('#post_service_type_id').selectpicker('refresh')
      $('#post_service_type_id').parent().show()
    else
      $('#post_service_type_id').parent().hide()


  $('#post_service_type_ids').parent().hide()
  types_2 = $('#post_service_type_ids').html()
  $('#post_service_category_ids').change -> 
    categories = $('#post_service_category_ids :selected')
    total = $('#post_service_type_ids')
    options = null
    if categories.length > 0
      options = "<option>All types</option>"
    i = 0
    while i < categories.length
      category = categories[i].text
      option = $(types_2).filter("optgroup[label='#{category}']").html()
      options = options + option
      i++
    if options
      $('#post_service_type_ids').html(options)
      $('#post_service_type_ids').selectpicker('refresh')
      $('#post_service_type_ids').parent().show()
    else
      $('#post_service_type_ids').parent().hide()













  # track check box of service_catories
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
