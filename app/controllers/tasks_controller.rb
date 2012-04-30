class TasksController < ApplicationController

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

        respond_to do |format|
            format.mobile
        end
    end

    def create
        @task = Task.new(params[:task])
        setDefaults! @task
        @task.save

        notification_type = NotificationType.find_by_name("NewTask")
        #shouldnt happen
        if notification_type.nil?
            notification_type = NotificationType.first
        end
        notification = nil
        @task.users.each do |user|
            notification = Notification.create(:notification_type => notification_type, :user => user, :notification_object => @task)
        end

        respond_to do |format|
            format.html { redirect_to tasks_url, notice: 'Task Created.' }
            format.mobile { redirect_to tasks_url, notice: 'Task Created.' }
        end
    end

    def edit
        @task = Task.find(params[:id])
        @users = current_project.users.all
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

        respond_to do |format|
            format.html { redirect_to tasks_url }
            format.mobile { redirect_to @task }
        end
    end

    def mark_complete
        task = Task.find(params[:id])
        if task.mark_complete
            flash[:success] = 'Task marked complete.'
            Notification.create(user: task.owner, notification_type: NotificationType.find_by_name("TaskComplete"))
            task.users.each do |user|
                if user != self.current_user
                    Notification.create(user: user, notification_type: NotificationType.find_by_name("TaskComplete"))
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
        @task = Task.find(params[:id])

        respond_to do |format|
            format.html
            format.mobile
        end
    end

    def destroy
        task = Task.find(params[:id])
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
