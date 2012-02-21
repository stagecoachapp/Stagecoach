class TasksController < ApplicationController


  def new
    @task = Task.new
    
    respond_to do |format|
      format.html
    end
  end

  def create
    #debugger
    #@task_categories = params[:task][:task_categories]
    #params[:task][:task_categories] = ""
    debugger
    @task = Task.new(params[:task])
    @task.save
    (@task_categories || []).each { |task_category| @task.task_categories << task_category}
    @task.save

    respond_to do |format|
      format.html
    end
  end

  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])
  end
  
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html
    end

  end

  def show
    @task = Task.find(params[:id])
  end
  
end
