class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new]

  def new
    @user = current_user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      respond_to do |format|
        format.html { redirect_to root_url }
      end
    end
  end

  def index
    @users = User.all
    respond_to do |format|
      format.html
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end

end
