class UserRolesController < ApplicationController
  # GET /user_roles
  # GET /user_roles.json
  def index
    @user_roles = self.current_project.user_roles.all

    @header = "User Roles"
    respond_to do |format|
      format.html # index.html.erb
      format.mobile
      format.json { render json: @user_roles }
    end
  end

  # GET /user_roles/1
  # GET /user_roles/1.json
  def show
    @user_role = UserRole.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_role }
    end
  end

  # GET /user_roles/new
  # GET /user_roles/new.json
  def new
    @user_role = UserRole.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_role }
    end
  end

  # GET /user_roles/1/edit
  def edit
    @user_role = UserRole.find(params[:id])
  end

  # POST /user_roles
  # POST /user_roles.json
  def create
    @user_role = UserRole.create(params[:user_role])
    @user_role.project = self.current_project
    @user_role.save

    respond_to do |format|
      if @user_role.save
        format.mobile { redirect_to user_roles_url, notice: 'User role was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /user_roles/1
  # PUT /user_roles/1.json
  def update
    @user_role = UserRole.find(params[:id])

    respond_to do |format|
      if @user_role.update_attributes(params[:user_role])
        format.html { redirect_to @user_role, notice: 'User role was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_roles/1
  # DELETE /user_roles/1.json
  def destroy
    @user_role = UserRole.find(params[:id])
    @user_role.destroy

    respond_to do |format|
      format.mobile { redirect_to user_roles_url }
      format.json { head :no_content }
    end
  end
end
