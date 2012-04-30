module TasksHelper

	def mark_task_complete_path(id)
		"/tasks/" + id.to_s + "/mark_complete"
	end

	def mark_task_pending_path(id)
		"/tasks/" + id.to_s + "/mark_pending"
	end
end
