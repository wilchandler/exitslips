# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->

  $('#id').change ->
    sectionID = $('#section_id').val()
    quizID = $("#id").val()
    console.log(quizID)
    if quizID
      console.log("GO ROYALS")
      $("#table-all-standards").hide()
      $.get "/sections/#{sectionID}/quizzes/#{quizID}", (data) ->
        console.log(data)
        populateQuizTable(data)
    else if quizID
      $("#table-quiz").remove()
      $("#table-all-standards").show()


populateQuizTable = (data) -> 
  $("<table id='table-quiz'></table>").insertAfter("#table-all-standards")
  $("#table-quiz").append("<tr id='header'></tr>")
  $("#header").append("<th>Name</th>")
  for key, value of data
    buildRows(key, value)
    buildHeaders(value)

buildRows = (id, questions) ->
  $("#table-quiz").append("<tr##{id}")
  




# NEW table
  #NEW table row
    #NEW table head 'name'
    # FOR EACH question
      # NEW table head for question
 #FOR EACH student     
  #NEW table row
    # NEW table head 'student name'
    # FOR EACH answer
      # NEW table data for answer


    

$("#table-all-standards").ready ->
  sectionID = $('#section_id').val()

  $.get "/sections/#{sectionID}", (data) ->
    console.log(data) 
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
    header = $(cell).closest('table').find('th').eq( cell.cellIndex )[0];
    if $(header).text() == content
      return cell

assignColor = (element, score) ->
  if score < 60
    $(element).attr('class', 'red-cell')
  else if score < 80
    $(element).attr('class', 'yellow-cell')
  else
    $(element).attr('class', 'green-cell')



