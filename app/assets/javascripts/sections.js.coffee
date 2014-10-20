# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#table-quiz").hide()

  $('#id').change ->
    sectionID = $('#section_id').val()
    quizID = $("#id").val()
    if quizID
      $("#table-all-standards").hide()
      $("#table-quiz").show()
      $.get "/sections/#{sectionID}/quizzes/#{quizID}", (data) ->
        console.log(data)
        populateQuizTable(data)
    else
      $("#table-quiz").hide()
      $("#table-all-standards").show()


populateQuizTable = (data) ->
  for key, value of data
    populateHeader(value)
    break
  for key, value of data
    row = findRowById(key)
    buildRows(key, value)

buildRows = (studentID, questions) ->
  row = findRowById(studentID)
  for question, answer of questions
    $("#quiz-#{studentID}").append("<td>#{answer}</td>")

findRowById = (id) ->
  $("tr##{id}")

populateHeader = (value) ->
  for question, answer of value
    $('#header').append("<th>#{question}</th>")







# populateQuizTable = (data) -> 
#   $("<table id='table-quiz'></table>").insertAfter("#table-all-standards")
#   $("#table-quiz").append("<tr id='header'></tr>")
#   $("#header").append("<th>Name</th>")
#   for key, value of data
#     buildRows(key, value)

# buildRows = (id, questions) ->
#   $("#table-quiz").append("<tr><th id=#{id}>#{id}</th>")
#   for question of questions
#     $("th##{id}").insertAfter("<td>#{question[0]}</td>")
#     $("#table-quiz").append("</tr>")
#     buildHeaders(question)

# buildHeaders = (question) ->
#     console.log("#{question} ROYALS")
#     $("#header").append("<th>#{question}</th>")
    




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



