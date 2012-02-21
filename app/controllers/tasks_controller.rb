class TasksController < ApplicationController



  def new
    @task = Task.new
    
    respond_to do |format|
      format.mobile
    end
  end

  def create
    @task = Task.new(params[:task])
    setDefaults @task
    @task.save
    (@task_categories || []).each { |task_category| @task.task_categories << task_category}
    @task.save

    respond_to do |format|
      format.html
      format.mobile { redirect_to tasks_url, notice: 'Task Created.' }
    end
  end

  def edit
    @task = Task.find(params[:id])
    respond_to do |format|
      format.mobile
    end
  end
  
  def update
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])

    respond_to do |format|
      format.html
      format.mobile { redirect_to tasks_url, notice: 'Task Updated.' }
    end
  end
  
  def index
    @tasks = Task.all

    respond_to do |format|
      format.mobile
    end

  end

  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.mobile { redirect_to tasks_url, notice: 'Task Deleted.' }
    end
  end
  
  def setDefaults(task)
    task.status = 0
    task.project_id = self.current_project
  end

end
