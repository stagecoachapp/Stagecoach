class CreateProjectsAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|
      t.integer :user_id
      t.integer :project_id
    end
  end
end
