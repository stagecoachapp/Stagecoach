class TasksController < InheritedResources::Base
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
end
