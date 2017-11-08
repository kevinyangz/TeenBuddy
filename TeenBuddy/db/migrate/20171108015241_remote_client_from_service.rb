class RemoteClientFromService < ActiveRecord::Migration[5.1]
  def change
    remove_column :services, :client_id
  end
end
