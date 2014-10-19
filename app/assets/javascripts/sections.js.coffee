# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$("#table-all-standards").ready ->
  sectionID = $('#section_id').val()

  $.get "/sections/#{sectionID}", (data) ->
    console.log(data) #
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
