//null means the user hasn't entered anything in that field yet
var validName = null;
var validEmail = null;

$(document).ready(function() {  
  
  $("#signup_email").bind('keyup blur input', function() {
    validEmail = validateEmail();
    validateButton();
    if (validEmail) {
      makeFieldGreen($(this));
      $('#signups-signup-form-email-help').css('display', '');
      $('#signups-signup-form-email-help').hide();
    }
    else {
      $('#signups-signup-form-email-help').show();
      $('#signups-signup-form-email-help').css('display', 'inline');
      makeFieldRed($(this));
    }
  });

 $("#signup_name").bind('keyup blur input', function() {
    validName = validateName();
    validateButton();
    if (validName) {
      $('#signups-signup-form-name-help').css('display', '');
      $('#signups-signup-form-name-help').hide();
      makeFieldGreen($(this));
    }
    else {
       makeFieldRed($(this));
      $('#signups-signup-form-name-help').show();
      $('#signups-signup-form-name-help').css('display', 'inline');
    }
  });

  $("#signups-signup-form-form").submit(function() {
      //if the user hasn't entered a field, the button will not be colored
      //indicate that they are not done yet by making the button red
      if(!$(document.forms["signups-signup-form-form"]["commit"]).hasClass("btn btn-success btn-large")) {
        if(validName == null) {
          $(document.forms["signups-signup-form-form"]["commit"]).removeClass().addClass("btn btn-danger btn-large");
          makeFieldRed($(document.forms["signups-signup-form-form"]["signup[name]"]));
          $('#signups-signup-form-name-help').show();
          $('#signups-signup-form-name-help').css('display', 'inline');
        }
        if(validEmail == null) {
          $(document.forms["signups-signup-form-form"]["commit"]).removeClass().addClass("btn btn-danger btn-large");
          $('#signups-signup-form-email-help').show();
          $('#signups-signup-form-email-help').css('display', 'inline');
          makeFieldRed($(document.forms["signups-signup-form-form"]["signup[email]"]));
        }
      }
        
      return $(document.forms["signups-signup-form-form"]["commit"]).hasClass("btn btn-success btn-large");
  });
});

function validateEmail() {
  var re = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i;
  return re.test($(document.forms["signups-signup-form-form"]["signup[email]"]).val()) && $(document.forms["signups-signup-form-form"]["signup[email]"]).val() != '';
}

function validateName() {
  return $(document.forms["signups-signup-form-form"]["signup[name]"]).val().length != '';
}

function validateButton() {
  if(validateEmail() && validateName() && validName != null && validEmail != null) {
    $(document.forms["signups-signup-form-form"]["commit"]).removeClass().addClass("btn btn-success btn-large");
  }
  else if(validName != null && validEmail != null){
    $(document.forms["signups-signup-form-form"]["commit"]).removeClass().addClass("btn btn-danger btn-large");
  }
}

function makeFieldRed(field) {
  //If the form validation fails, what was the input object becomes field_with_errors with a child input
  //This creates an extra parent between the field and the control-group object
  if($(field).parent().hasClass('field_with_errors')) {
    $(field).parent().parent().parent().removeClass().addClass('control-group error');
  }
  else {
    $(field).parent().parent().removeClass().addClass('control-group error');
  }
}

function makeFieldGreen(field) {
  //If the form validation fails, what was the input object becomes field_with_errors with a child input
  //This creates an extra parent between the field and the clearfix object
  if($(field).parent().hasClass('field_with_errors')) {
    $(field).parent().parent().parent().removeClass().addClass('control-group success');
  }
  else {
    $(field).parent().parent().removeClass().addClass('control-group success');
  }
}
