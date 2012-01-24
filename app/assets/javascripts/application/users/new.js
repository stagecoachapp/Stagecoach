$(document).ready(function() {

  $("#user_email").change(function() {
    var re = /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})$/i;
    if (re.test($(this).val())) {
      makeFieldGreen($(this));
    }
    else {
      makeFieldRed($(this));
    }
  });

 $("#user_name").change(function() {
    if ($(this).val().length < 4) {
      makeFieldRed($(this));
    }
    else {
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
  $(field).parent().parent().removeClass().addClass('clearfix error');
}

function makeFieldGreen(field) {
  $(field).parent().parent().removeClass().addClass('clearfix success');
}
