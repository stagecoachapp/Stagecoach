class TasksController < ApplicationController



  def new
    @task = Task.new
    
    respond_to do |format|
      format.html
    end
  end

  def create
    @task = Task.new(params[:task])
    setDefaults @task
    @task.save
    (@task_categories || []).each { |task_category| @task.task_categories << task_category}
    @task.save

    respond_to do |format|
      format.html { redirect_to @tasks.index, notice: 'Task Created.' }
    end
  end

  def edit
    @task = Task.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
  
  def update
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])
    respond_to do |format|
      format.html { redirect_to @tasks.index, notice: 'Task Updated.' }
    end
  end
  
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html
    end

  end

  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
  
  def setDefaults(task)
    task.status = 0
    task.project_id = self.current_project
  end

end
