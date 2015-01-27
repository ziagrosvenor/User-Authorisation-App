$(document).ready ->
  message = ''
  form = $('#signup-form')

  form.validate
    rules:
      firstname: 'required'
      surname: 'required'
      email:
        required: true
        email: true
      confirmEmail:
        required: true
        equalTo: '#email'
      password:
        required: true
        minlength: 6
    submitHandler: () ->
      $.post '/signup',
        form.serialize(),
        (data) ->
          console.log(data)
          message = data.message
          if message == "success"
            form.html('You can now login')
          else
            form.append('Email already registered')
        , 'json'
      return