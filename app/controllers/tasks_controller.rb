class TasksController < ApplicationController
  
  def new
    @task = Task.new
    respond_to do |format|
      format.html
      format.json { render :json => @task }
    end
  end
  
  def create
    @task = Task.new(params[:task])
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to root_url }
        format.json { render :json => @task }
      else
        format.html { redirect_to new_task_path }
        format.json { render :json => @task}
      end
    end
  end
  
  def index
    @tasks = Task.all
    
    respond_to do |format|
      format.html
      format.json { render :json => @tasks}
    end
  end

end