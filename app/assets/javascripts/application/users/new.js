$(document).ready(function() {

  $("#user_email").bind('change blur', function() {
    var re = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i;
    if (re.test($(this).val()) && $("#user_email").val() != '') {
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
    if ($(this).val().length < 3) {
      makeFieldRed($(this));
      $('#users-signup-form-name-help').show();
      $('#users-signup-form-name-help').css('display', 'block !important');
    }
    else {
      $('#users-signup-form-name-help').css('display', '');
      $('#users-signup-form-name-help').hide();

       makeFieldGreen($(this));
    }
  });

  /*$("#users-signup-form-form").submit(function() {
    alert(numberOfCorrectRequiredFields+" "+numberOfRequiredFields
    if(numberOfCorrectRequiredFields < numberOfRequiredFields) {
      return false;
    }
  });*/
});

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
    $(field).parent().parent().parent().removeClass().addClass('clearfix successs');
  }
  else {
    $(field).parent().parent().removeClass().addClass('clearfix successs');
  }
}
