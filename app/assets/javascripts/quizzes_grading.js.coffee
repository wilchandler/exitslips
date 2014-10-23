$('.grading-area').ready ->
  loadNextQuestion()

  $('.sortable').draggable({revert: "invalid"})

  $('#correct-hit-box').droppable {
    activeClass: "ui-state-default",
    hoverClass: "ui-state-hover",
    drop: (event, ui) ->
      answerID = ui.draggable.attr('id')
      updateGradingArea(ui.draggable)
      sendGrade(answerID, "true")
  }

  $('#incorrect-hit-box').droppable({
    activeClass: "ui-state-default",
    hoverClass: "ui-state-hover",
    drop: (event, ui) ->
      answerID = ui.draggable.attr("id")
      updateGradingArea(ui.draggable)
      sendGrade(answerID, "false")
  })

#   $(document).keydown (e) ->
#     switch(e.which)
#       when 37 then processGrade('false')
#       when 39 then processGrade('true')

# processGrade = (mark) ->
#   answerID = $('.active-grading .grading-answer')

sendGrade = (answerID, mark) ->
  $.ajax "/answers/#{answerID}",
    type: "PATCH",
    data: {correct: mark},
    success: (response) ->
      # ???
    dataType: "text"

loadNextQuestion = ->
  question = $('.grading-question')[0]
  if question == undefined
    allCaughtUp()
    return
  makeActive(question)
  answer = getNextAnswer(question)
  if answer == null
    $(question).remove()
    loadNextQuestion()
  else
    makeActive(answer)

updateGradingArea = (draggable) ->
  draggable.remove()
  question = draggable.parent()[0]
  answer = getNextAnswer(question)
  if answer == null
    $(question).remove()
    loadNextQuestion()
  else
    makeActive(answer)

getNextAnswer = (question) ->
  answers = $(question).children('.grading-answer')
  if answers.length == 0
    return null
  else
    return answers[0]

makeActive = (element) ->
  $(element).removeClass('grading-inactive')
  $(element).addClass('grading-active')

allCaughtUp = ->
  $('.grading-area').append("<h1>All caught up!</h1>")


