class ChangeTypeToRoleForUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :string
    remove_column :users, :type
  end
end
