class ProjectsController < ApplicationController

    def menu

        respond_to do |format|
            format.html
            format.mobile
        end
    end

    # GET /projects
    # GET /projects.json
    def index
        @projects = []
        unless self.current_project.nil?
            @projects << self.current_project
        end
        self.current_user.projects.each do |project|
            if project != self.current_project
                @projects << project
            end
        end
        respond_to do |format|
            format.html
            format.mobile # index.html.erb
        end
    end

    def join
        respond_to do |format|
            format.html
            format.mobile
        end
    end

    def joinaction
        project_name = params[:projectname]
        project_name.downcase!
        @project = Project.find_by_name(project_name)
        # Project does not exist check
        if not @project == nil
            # 'Already in project' check
            if !(current_user.projects.include?(@project))
                 # 'Password' check
                if @project.password == params[:projectpassword]
                    self.current_user.projects.push(@project)
                    self.current_user.save
                    self.current_project=(@project.id)
                    go_to = root_path
                    flash[:success] = 'Joined Project Successfully.'
                # Incorrect Password page
                else
                    go_to = projects_path
                    flash[:success] = 'Incorrect Password.'
                end
            # Already in project page
            else
                go_to = projects_path
                flash[:success] = 'Already in Project.'
            end
        else
            go_to = projects_path
            flash[:success] = 'Project does not exist.'
        end
        respond_to do |format|
            format.html { redirect_to go_to}
            format.mobile { redirect_to go_to}
        end
    end

    # GET /projects/1
    # GET /projects/1.json
    def show
        @project = Project.find(params[:id])
        @people = @project.users.all
        @administrators = @project.administrators.all
        respond_to do |format|
            format.mobile # show.html.erb
            format.json { render json: @project }
        end
    end

    #POST /project/1
    def switch
        @project = Project.find_by_id(params[:id])
        if !@project.nil?
            self.current_project= @project
        end
        respond_to do |format|
            format.html { redirect_to projects_path }
            format.mobile { redirect_to projects_path }
        end
    end

    # GET /projects/new
    # GET /projects/new.json
    def new
        @project = Project.new
        @title = "Create Project"
        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @project }
        end
    end

    # GET /projects/1/edit
    def edit
        @project = Project.find(params[:id])
        @title = "Edit " + @project.name
    end

    # PUT /projects/1
    # PUT /projects/1.json
    def update
        params[:project][:administrator_ids] ||= []
        @project = Project.find(params[:id])
        @title = "Update " + @project.name
        if params[:project][:password] == ""
            params[:project].delete :password
            end
            respond_to do |format|
                project_name = params[:project][:name]
                project_name.downcase!
                project_password = params[:project][:password]
                @project.name = project_name
                @project.password = project_password
            if @project.save()
                if current_project == @project
                    self.current_project=(@project.id)
                end
                format.html { redirect_to @project, notice: 'Project was successfully updated.' }
                format.json { head :no_content }
                format.mobile { redirect_to @project, notice: 'Project was successfully updated.' }
            else
                format.html { render action: "edit" }
                format.json { render json: @project.errors, status: :unprocessable_entity }
                format.mobile { render action: "edit" }
            end
        end
    end

    def create
        project_name = params[:project][:name]
        project_name.downcase!
        if not Project.all.map{|p| p.name}.include?(project_name)
            project_password = params[:project][:password]
            @new_project= Project.new()
            @new_project.name = project_name
            @new_project.password = project_password
            @new_project.owner = self.current_user
            @new_project.administrators << self.current_user
            @new_project.users << current_user
            if @new_project.save
                flash[:success] = "Project successfully created"
            else
                flash[:error] = "Error creating project"
            end
            self.current_project = @new_project
            go_to = root_path
        else
            flash[:error] = "Sorry, there is already a project with that name"
            go_to = projects_path
        end
        respond_to do |format|
            format.mobile {redirect_to go_to}
            format.html {redirect_to go_to}
        end
    end


    # DELETE /projects/1
    # DELETE /projects/1.json
    def destroy
        @project = Project.find(params[:id])
        @title = "Delete " + project.name
        if self.current_project == @project
            @project.destroy
            self.current_project = self.current_user.projects.last

            if self.current_project.nil?
                respond_to do |format|
                    format.html { redirect_to root_url }
                    format.json { head :no_content }
                    format.mobile { redirect_to root_url }
                end
            else
                respond_to do |format|
                    format.html { redirect_to projects_path }
                    format.json { head :no_content }
                    format.mobile { redirect_to projects_path }
                end
            end
        else
            @project.destroy

            respond_to do |format|
                format.html { redirect_to projects_path }
                format.json { head :no_content }
                format.mobile { redirect_to projects_path }
            end
        end
    end
end









