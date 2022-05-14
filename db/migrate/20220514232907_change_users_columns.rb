class ChangeUsersColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :slug, :string
    add_column :users, :public_uid, :string
    add_index :users, :public_uid, unique: true
  end
end
