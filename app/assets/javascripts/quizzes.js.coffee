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
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('form').on 'click', '.remove_question', (event) ->
    if window.confirm("Are you sure?")
      # removeField(this)
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('fieldset').hide()
      event.preventDefault()

# FUNCTION BELOW! WHY DON'T YOU WORK!?!?!?

# removeField (deletion_link) ->
#   jQuery(deletion_link).prev('input[type=hidden').val('1')
#   jQuery(deletion_link).closest('fieldset').hide()
#   event.preventDefault()
