class ChangeRoleToTypeInUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :role
    add_column :users, :type, :string
  end
end
