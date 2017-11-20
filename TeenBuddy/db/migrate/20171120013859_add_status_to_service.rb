class AddStatusToService < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :status, :interger, default:0
  end
end
