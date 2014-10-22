$('#student-join-section').ready ->
  $messageDisplay = $("#enrollment-message")
  $form = $('#student-join-section-form')
  $input = $('input#passcode')
  url = $form.attr('action')

  $form.submit (event) ->
    event.preventDefault()
    input = $.trim($input.val())
    if input == ""
      updateMessage("Must enter a passcode")
    else
      $.ajax (url + ".json"),
        type: 'POST',
        dataType: "JSON",
        data: {passcode: input},
        success: (data) ->
          if data.hasOwnProperty("error")
            updateMessage(data["error"])
          if data.hasOwnProperty("success")
            window.location.href = data["success"]
        error: (data) ->
          updateMessage("Something went wrong...")

  updateMessage = (text) ->
    $messageDisplay.empty()
    $messageDisplay.text(text)
