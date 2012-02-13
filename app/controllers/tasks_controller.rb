class TasksController < ApplicationController


  def new
    @task = Task.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @task = Task.new(params[:task])
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
    debugger
    @tasks = Task.all

    respond_to do |format|
      format.html
    end

  end

  def show
    @task = Task.find(params[:id])
  end
  
end
