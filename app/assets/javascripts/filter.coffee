$(document).on "page:change", ->
  $('.js_select_assignee').multiselect()
  $('.js_select_status').multiselect()
  $('.jsdatetimepicker').datetimepicker 
    language: 'pt-RU'
    format: 'yyyy-MM-dd'
  return