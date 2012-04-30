class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|

    	t.has_attached_file :file
    	t.references :asset_object, :polymorphic => true

    	t.timestamps
    end
  end
end
