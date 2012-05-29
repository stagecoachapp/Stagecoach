//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.

$(document).ready(function() {

	//Add user modal related functions
	$("#tasks-new-add-user-button").click(function() {
		$("#tasks-new-add-user-modal").modal('show');
	});
	$("#tasks-new-add-user-modal-select-button").click(function() {
		var checkedUsers = $('input[name=contacts-group]:checked');
		//the first user should populate the field already in the form
		$(".tasks-new-user-id").remove();
		$(".tasks-new-user-name").remove();
		$("#tasks-new-add-user-button").before('<input type="hidden" class="tasks-new-user-id" name="task[user_ids][]">');
		$("#tasks-new-add-user-button").before('<input disabled="disabled" class="tasks-new-user-name" name="user_name", type="text">');


		if(checkedUsers.length > 0)
		{
			$(".tasks-new-user-id").first().val($(checkedUsers[0]).val());
			$(".tasks-new-user-name").first().val($(checkedUsers[0]).next().text());
			$("#tasks-new-add-user-button i").removeClass().addClass("icon-refresh");
		}
		var lastUserElement = $(".tasks-new-user-name");
		//the rest of the users should populate new fields
		for(i = 1; i < checkedUsers.length; i++)
		{
			lastUserElement.after('<input type="hidden" class="tasks-new-user-id" name="task[user_ids][]">');
			lastUserElement = lastUserElement.after('<input disabled="disabled" class="tasks-new-user-name" name="user_name", type="text" style="display: block">');
			$(".tasks-new-user-id").last().val($(checkedUsers[i]).val());
			$(".tasks-new-user-name").last().val($(checkedUsers[i]).next().text());
		}
		//make the last new user name inline
		$(".tasks-new-user-name").last().css("display", "inline");
		$("#tasks-new-add-user-modal").modal('hide');
	});
	$("#tasks-new-form").submit(function() {
		$.param("user-id", $("#tasks--user").data('user-id'));
	});
	//end add user modal related functions


$('#tasks-tasks-new').datepicker()
	.on('changeDate', function(ev){

	});

$('#tasks-tasks-time').timepicker();

});