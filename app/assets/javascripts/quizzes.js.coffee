# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    # removeField(this)
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    console.log($(this).data('fields').replace(regexp, time))
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('form').on 'click', '.remove_question', (event) ->
    if window.confirm("Are you sure?")
      # removeField(this)
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('fieldset').hide()
      event.preventDefault()

  $('form').on 'change', '.open-response-checkbox', (event) ->
    handleOpenResponseBox(event.target)

  $('form').on 'submit', (event) ->
    validateStandard()
    validateOption()






handleOpenResponseBox = (box) ->
  question = $(box).closest('fieldset')
  if $(box).prop("checked") == true
    $(question).children('fieldset').hide()
    $(question).children('.add_fields').hide()
  else if $(box).prop("checked") == false
    $(question).children('fieldset').show()
    $(question).children('.add_fields').show()


validateStandard = () ->
  standard = $("#standard").val();
  if (standard == null || standard == "")
    alert("Standard can't be blank.")
    return false

# validateSection = () ->
#   if $("input[type='checkbox']").prop("checked") == false
#     alert("You must select a section.")
#     return false


validateOption = () ->
  if $(".open-response-checkbox").prop("checked") == false
    alert("Questions must either have answers or be open response.")
    return false






# removeField (deletion_link) ->
#   jQuery(deletion_link).prev('input[type=hidden').val('1')
#   jQuery(deletion_link).closest('fieldset').hide()
#   event.preventDefault()
