class AddMoreFieldsToTableUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :full_name, :string
    add_column :users, :photo, :string
    add_column :users, :cover_image, :string
    add_index :users, :username, unique: true
  end
end
