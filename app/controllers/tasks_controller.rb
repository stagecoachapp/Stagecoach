class TasksController < ApplicationController
    require 'time'
    def menu

        respond_to do |format|
            format.html
            format.mobile
        end

    end


    def new
        @task = Task.new
        #set the priority to the first priority to make sure there is a default value
        @task.task_priority = TaskPriority.first
        @task_categories = self.current_project.task_categories.find(:all)
        @users = self.current_project.users.all
        @time = Time.now.in_time_zone + 2000
        respond_to do |format|
            format.mobile
        end
    end

    def create
        if not is_mobile_device?
            date = Date.strptime(params[:date],"%m-%d-%Y").to_time
            date = date.change(:hour => Time.parse(params[:time2]).hour, :min => Time.parse(params[:time2]).min)
            params[:task][:time] = date
            params[:task][:task_priority] = TaskPriority.find_by_name("Low")
            params[:task][:task_status] = TaskPriority.find_by_name("Pending")
            @task = Task.new(params[:task])
            setDefaults! @task
        else
            @task = Task.new(params[:task])
            setDefaults! @task
        end

        @task.save

        notification_type = NotificationType.find_or_create_by_name("NewTask")
        notification = nil
        @task.users.each do |user|
            if user != self.current_user
                notification = Notification.create(:notification_type => notification_type, :user => user, :notification_object => @task)
            end
        end



        respond_to do |format|
            format.html { redirect_to tasks_url, notice: 'Task Created.' }
            format.mobile { redirect_to tasks_url, notice: 'Task Created.' }
        end
    end

    def edit
        @task = Task.find(params[:id])
        @users = current_project.users.all
        @time = @task.time
        respond_to do |format|
            format.html
            format.mobile
        end
    end

    def update
        params[:task][:task_category_ids] ||= []
        params[:task][:user_ids] ||= []
        @task = Task.find(params[:id])
        @task.update_attributes(params[:task])

        #send a notification to the task owner
        if self.current_user != @task.owner
            Notification.create(:notification_type => NotificationType.find_or_create_by_name("UpdatedTask"), :user => @task.owner, :notification_object => @task)
        end
        #send a notification to all other users on the task
        @task.users.each do |user|
            if user != self.current_user and user != @task.owner
                Notification.create(:notification_type => NotificationType.find_or_create_by_name("UpdatedTask"), :user => user, :notification_object => @task)
            end
        end


        respond_to do |format|
            format.html { redirect_to tasks_url }
            format.mobile { redirect_to @task }
        end
    end

    def mark_complete
        task = Task.find(params[:id])
        if task.mark_complete
            flash[:success] = 'Task marked complete.'
            #send a notification to the task owner
            if self.current_user != task.owner
                Notification.create(:notification_type => NotificationType.find_or_create_by_name("CompletedTask"), :user => task.owner, :notification_object => task)
            end
            #send a notification to all other users on the task
            task.users.each do |user|
                if user != self.current_user and user != task.owner
                    Notification.create(:notification_type => NotificationType.find_or_create_by_name("CompletedTask"), :user => user, :notification_object => task)
                end
            end
        else
            flash[:notice] = 'Task is already marked complete.'
        end
        respond_to do |format|
            format.html { redirect_to tasks_path }
            format.mobile { redirect_to tasks_path}
        end
    end

    def index
        if (params[:mytasks].nil?)
            if(params[:name].nil?)
                @tasks = self.current_project.tasks.find(:all, :conditions => { :task_status_id => TaskStatus.find_by_name("Pending").id})
            else
                @tasks = []
                self.current_project.task_categories.find_by_name(params[:name]).tasks.each do |task|
                    if task.project == self.current_project
                        @tasks << task
                    end
                end
            end

            @header = "All Tasks"
        else
            @tasks = []
            self.current_project.tasks.all.each do |task|
                task.users.each do |user|
                    if user == self.current_user
                        @tasks << task
                    end
                end
            end
            @header = "My Tasks"
        end

        respond_to do |format|
            format.html
            format.mobile
            format.js
        end

    end

    def index_completed
        if (params[:mytasks].nil?)
            if(params[:name].nil?)
                @tasks = self.current_project.tasks.find(:all, :conditions => { :task_status_id => TaskStatus.find_by_name("Complete").id})
            else
                @tasks = []
                self.current_project.task_categories.find_by_name(params[:name]).tasks.each do |task|
                    if task.project == self.current_project
                        @tasks << task
                    end
                end
            end

            @header = "All Tasks"
        else
            @tasks = []
            self.current_project.tasks.all.each do |task|
                task.users.each do |user|
                    if user == self.current_user
                        @tasks << task
                    end
                end
            end
            @header = "My Tasks"
        end

        respond_to do |format|
            format.html
            format.mobile
            format.js
        end

    end

    def show
        @task = self.current_project.tasks.find_by_id(params[:id])
        if @task.nil?
            flash[:success] =  'Task not found. Maybe it is on a different project'
            respond_to do |format|
                format.html { redirect_to tasks_path }
                format.mobile { redirect_to tasks_path }
            end
        else
            respond_to do |format|
                format.html
                format.mobile
            end
        end
    end

    def destroy
        task = self.current_project.tasks.find_by_id(params[:id])
        task.destroy

        respond_to do |format|
            format.html { redirect_to tasks_url, notice: 'Task Deleted.' }
            format.mobile { redirect_to tasks_url, notice: 'Task Deleted.' }
        end
    end

    def setDefaults!(task)
        task.task_status = TaskStatus.first
        task.owner ||= self.current_user
        task.project_id ||= self.current_project.id
        task.task_status = TaskStatus.find_by_name("Pending")
        task.active = true
    end
end
