class AddTypeToService < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :type, :boolean
  end
end
