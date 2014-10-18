# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$("#table-all-standards").ready ->
  sectionID = $('#section_id').val()
  console.log(sectionID)

  $.get "/sections/#{sectionID}", (data) ->
    console.log(data)
    # $(:contains(data.))


# FOR EACH student name
  # FIND the table row that corresponds with that name
  # FOR EACH
