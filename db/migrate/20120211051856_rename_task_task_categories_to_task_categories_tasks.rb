class RenameTaskTaskCategoriesToTaskCategoriesTasks < ActiveRecord::Migration
  def change
    rename_table :tasks_task_categories, :task_categories_tasks
  end
end
