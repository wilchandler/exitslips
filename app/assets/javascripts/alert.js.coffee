$(".new_quiz, .edit_quiz").ready ->
  options = []

  $.get '/teachers/1', (data) ->
    for i of data
      options.push( new Standard(data[i]) )
    console.log(options)

class Standard
  constructor: (args) ->
    @id = args.id
    @code = args.code
    @description = args.description
