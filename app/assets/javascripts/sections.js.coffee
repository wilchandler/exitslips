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



