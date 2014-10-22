# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$('.section_tables').ready ->
  $(".quiz_table").hide()
  $('#id').change ->
    sectionID = $('#section_id').val()
    quizID = $("#id").val()
    if quizID
      $("#table-all-standards").hide()
      $(".quiz_table").hide()
      $("#quiz_table_#{quizID}").show()
      unless ($("#quiz_table_#{quizID} .student-row").siblings().length)
        $.get "/sections/#{sectionID}/quizzes/#{quizID}", (data) ->
          populateQuizTable(data, quizID)
    else
      $(".quiz_table").hide()
      $("#table-all-standards").show()


populateQuizTable = (data, quizID) ->
  for key, value of data
    populateHeader(value, quizID)
    break
  for key, value of data
    buildRows(key, value, quizID)

buildRows = (studentID, questions, quizID) ->
  for question, answer of questions
    $("#quiz_table_#{quizID} #quiz-#{studentID}").append("<td>#{answer}</td>")


populateHeader = (value, quizID) ->
  for question, answer of value
    $("#quiz_table_#{quizID} #header").append("<th>#{question}</th>")

depopulateTable = ->
  console.log($("#table-quiz #student-name").siblings())
  $("#table-quiz #student-name").siblings().remove()
  $("#table-quiz .student-row").siblings().remove()



# Building table for all standards in a section

$("#table-all-standards").ready ->
  sectionID = $('#section_id').val()

  $.get "/sections/#{sectionID}", (data) ->
    populateSectionTable(data)

populateSectionTable = (data) ->
  for key, value of data
    row = findRowById(key)
    populateRow(row, value)

findRowById = (id) ->
  $("tr##{id}")

populateRow = (row, scores) ->
  tds = row.children("td")
  for code, score of scores
    match = findHeader(tds, code)
    assignColor(match, score)

findHeader = (cells, content) ->
  for cell in cells
    header = $(cell).closest('table').find('td').eq( cell.cellIndex )[0];
    if $(header).text() == content
      return cell

assignColor = (element, score) ->
  if score < 60
    $(element).attr('class', 'red-cell')
  else if score < 80
    $(element).attr('class', 'yellow-cell')
  else
    $(element).attr('class', 'green-cell')



# Getting Groups on individual quiz views

$(document).on 'click', '.add-groups-link', (event) ->
  event.preventDefault()
  showGroupsForm(event.target)

showGroupsForm = (link) ->
  $(link).hide()
  $(link).parent().children('form').show()

$(document).on 'click', '.get-groups-button', (event) ->
  event.preventDefault()
  form = $(this).closest('form')[0]
  getGroups(form)

getGroups = (form) ->
  url = $(form).attr('action')
  args = $(form).serializeArray()
  $.ajax url,
    type: 'GET',
    dataType: "JSON",
    data: args
    success: (data) ->
      displayGroups(form, data.groups)

displayGroups = (form, groups) ->
  listing = $(form).children('.group-listing')
  listing.empty()
  $(form).children('.group-listing').empty()
  for group in groups
    list = buildGroupView(group)
    listing.append(list)

buildGroupView = (group) ->
  view = "<ul>"
  for student in group
    view += "<li>#{student}</li>"
  view += "</ul>"


