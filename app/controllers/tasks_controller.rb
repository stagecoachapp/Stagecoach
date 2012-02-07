class TasksController < InheritedResources::Base
  
  def edit
    @task = Task.find(params[:id])
  end
  
end
