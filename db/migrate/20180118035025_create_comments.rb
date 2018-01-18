class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      #fields for what we want to keep track of
      t.text :message
      t.string :rating
      t.integer :user_id
      t.integer :place_id
      t.timestamps
      t.timestamps
    end
    #An index to quickly look up items in the database
    add_index :comments, [:user_id, :place_id]
    add_index :comments, :place_id
  end
end
