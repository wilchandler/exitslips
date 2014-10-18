# $(".new_quiz, .edit_quiz").ready ->
#   fuse = undefined
#   standards = []

#   options =
#     shouldSort: true
#     threshold: 0.6
#     keys: [
#       "code"
#       "description"
#     ]

#   $.get '/standards', (data) ->
#     for d in data
#       standards.push(new Standard(d))
#     fuse = new Fuse(standards, options)

#     res = fuse.search('E.A')
#     for i in res
#       console.log(i.display())

#   # $('#standard_query').keyup ->
#   #   alert "YEAH"

# class Standard
#   constructor: (args) ->
#     @id = args.id
#     @code = args.code
#     @description = args.description
#   display: ->
#     "<option value=#{@id}>#{@code}: #{@description}</option>"
