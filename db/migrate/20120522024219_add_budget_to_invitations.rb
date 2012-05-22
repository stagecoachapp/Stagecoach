class AddBudgetToInvitations < ActiveRecord::Migration
  def change
  	add_column :invitations, :budget, :string
  end
end
