jQuery ->
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
