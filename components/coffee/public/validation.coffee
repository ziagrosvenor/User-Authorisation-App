$(document).ready () ->
  $('#signup-form').validate
  	rules:
      firstname: 'required'
      surname: 'required'
      email:
      	required: true
      	email: true
      confirmEmail:
      	required: true
      	equalTo: 'email'
      password:
      	required: true
      	minlength: 6
      confirmPassword:
      	required: true
      	minlength: 6
      	equalTo: 'password'