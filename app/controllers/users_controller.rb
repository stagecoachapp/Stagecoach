class UsersController < ApplicationController

	skip_before_filter :require_login, :only => [:new]

  # GET /users
  # GET /users.json
  def index
    if(params[:user_role].nil?)
      @users = self.current_project.users.find(:all)
    else
      @users = self.current_project.user_roles.find(params[:user_role]).users
    end

    @header = "Users"
    respond_to do |format|
      format.mobile # index.html.erb
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.mobile # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = current_user
    if self.current_project.nil?
      @user_roles = UserRole.all
    else   
      @user_roles = self.current_project.user_roles
    end

    respond_to do |format|
      format.mobile # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    if self.current_project.nil?
      @user_roles = UserRole.all
    else   
      @user_roles = self.current_project.user_roles
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.mobile { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    params[:user][:user_role_ids] ||= []
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.mobile { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
