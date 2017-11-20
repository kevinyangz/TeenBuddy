class ChangeTypeInService < ActiveRecord::Migration[5.1]
  def change
    remove_column :services, :type
    add_column :services, :enrollType, :boolean
  end
end
