$(document).ready(function() {
  
  $("#user_email").bind('change blur', function() {
    
    if (validateEmail($(this))) {
      makeFieldGreen($(this));
      $('#users-signup-form-email-help').css('display', '');
      $('#users-signup-form-email-help').hide();
    }
    else {
      $('#users-signup-form-email-help').show();
      $('#users-signup-form-email-help').css('display', 'block !important');
      makeFieldRed($(this));
    }
  });

 $("#user_name").bind('change blur', function() {
    if (validateName($(this))) {
     $('#users-signup-form-name-help').css('display', '');
      $('#users-signup-form-name-help').hide();
       makeFieldGreen($(this));
    }
    else {
       makeFieldRed($(this));
      $('#users-signup-form-name-help').show();
      $('#users-signup-form-name-help').css('display', 'block !important');
    }
  });

  $("#users-signup-form-form").submit(function() {
      return validateEmail(document.forms["users-signup-form-form"]["user[email]"]) && validateName(document.forms["users-signup-form-form"]["user[name]"]);
  });
});

function validateEmail(field) {
  var re = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i;
  return re.test($(field).val()) && $("#user_email").val() != '';
}

function validateName(field) {
  return $(field).val().length >= 3;
}

function makeFieldRed(field) {
  //If the form validation fails, what was the input object becomes field_with_errors with a child input
  //This creates an extra parent between the field and the clearfix object
  if($(field).parent().hasClass('field_with_errors')) {
    $(field).parent().parent().parent().removeClass().addClass('clearfix error');
  }
  else {
    $(field).parent().parent().removeClass().addClass('clearfix error');
  }
}

function makeFieldGreen(field) {
  //If the form validation fails, what was the input object becomes field_with_errors with a child input
  //This creates an extra parent between the field and the clearfix object
  if($(field).parent().hasClass('field_with_errors')) {
    $(field).parent().parent().parent().removeClass().addClass('clearfix success');
  }
  else {
    $(field).parent().parent().removeClass().addClass('clearfix success');
  }
}
