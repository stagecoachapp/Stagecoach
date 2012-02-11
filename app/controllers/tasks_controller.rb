class TasksController < InheritedResources::Base
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])
  end
  
  def index
    @tasks = Task.joins(:task_category).where('task_category.name=?', params[:name])
  end

  def show
    @task = Task.find(params[:id])
  end
  
end
