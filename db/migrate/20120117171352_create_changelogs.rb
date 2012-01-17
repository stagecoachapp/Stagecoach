class CreateChangelogs < ActiveRecord::Migration
  def change
    create_table :changelogs do |t|
      t.string :description
      t.string :developer

      t.timestamps
    end
  end
end
