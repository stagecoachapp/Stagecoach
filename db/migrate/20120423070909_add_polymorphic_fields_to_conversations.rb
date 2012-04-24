class AddPolymorphicFieldsToConversations < ActiveRecord::Migration
	def change
		add_column :conversations, :conversation_object_id, :integer
		add_column :conversations, :conversation_object_type, :string
	end
end
