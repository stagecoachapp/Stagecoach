class TaskCategoriesController < ApplicationController

  def index
    @task_categories = TaskCategory.all

    respond_to do |format|
      format.html
    end
  end

  def new
    @task_category = TaskCategory.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @task_category = TaskCategory.new(params[:task_category])

    if @task_category.save
      respond_to do |format|
        format.html { redirect_to task_categories_url}
      end
    end
  end

end
