$('.grading-area').ready ->
  loadNextQuestion()

  $('.sortable').draggable({revert: "invalid"})

  $('#correct-hit-box').droppable {
    activeClass: "ui-state-default",
    hoverClass: "ui-state-hover",
    drop: (event, ui) ->
      $element = ui.draggable
      $element.animate({left: "+=100%"}, ->
        processMark($element, "true")
      )
  }

  $('#incorrect-hit-box').droppable({
    activeClass: "ui-state-default",
    hoverClass: "ui-state-hover",
    drop: (event, ui) ->
      $element = ui.draggable
      $element.animate({left: "-=100%"}, ->
        processMark($element, "false")
      )
  })

  $(document).keyup (e) ->
    switch e.which
      when 37 # left arrow key
        $element = $('.grading-question .grading-active')
        $element.animate({left: "-=100%"}, ->
          processMark($element, "false")
        )
      when 39 # right arrow key
        $element = $('.grading-question .grading-active')
        $element.animate({left: "+=100%"}, ->
          processMark($element, "true")
        )


processMark = ($element, mark) ->
  answerID = $element.attr("id")
  sendGrade(answerID, mark)
  updateGradingArea($element)

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

updateGradingArea = ($element) ->
  $element.remove()
  question = $element.parent()[0]
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
  $('.grading-area').append("<h1>Quiz graded!</h1>")
  $('#correct-hit-box').hide()
  $('#incorrect-hit-box').hide()


