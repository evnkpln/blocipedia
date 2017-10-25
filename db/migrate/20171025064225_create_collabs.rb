class CreateCollabs < ActiveRecord::Migration
  def change
    create_table :collabs do |t|
      t.integer :user_id
      t.integer :wiki_id
      t.timestamps null: false
    end

    add_index :collabs, :id, unique: true
    add_index :collabs, :user_id
    add_index :collabs, :wiki_id
  end
end
