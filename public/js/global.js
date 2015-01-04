$(document).ready(function() {
  var form, message;
  message = '';
  form = $('#signup-form');
  return form.validate({
    rules: {
      firstname: 'required',
      surname: 'required',
      email: {
        required: true,
        email: true
      },
      confirmEmail: {
        required: true,
        equalTo: '#email'
      },
      password: {
        required: true,
        minlength: 6
      }
    },
    submitHandler: function() {
      $.post('/signup', form.serialize(), function(data) {
        console.log(data);
        message = data.message;
        if (message === "success") {
          return form.html('You can now login');
        } else {
          return form.append('Email already registered');
        }
      }, 'json');
    }
  });
});
