$(".new_quiz, .edit_quiz").ready ->
  fuse = undefined

  options =
    shouldSort: true
    threshold: 0.6
    keys: [
      "code"
      "description"
    ]

  $.get '/teachers/1', (data) ->
    fuse = new Fuse(data, options)
