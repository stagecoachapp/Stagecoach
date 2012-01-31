class TasksController < ApplicationController
  
  def new
    @task = Task.new
    respond_to do |format|
      format.mobile
      format.html
      format.json { render :json => @task }
    end
  end

end