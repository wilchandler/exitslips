$(".new_quiz, .edit_quiz").ready ->
  fuse = undefined

  options =
    shouldSort: true
    threshold: 0.6
    keys: [
      "code"
      "description"
    ]

  $.get '/standards', (data) ->
    fuse = new Fuse(data, options)
    console.log(data)
