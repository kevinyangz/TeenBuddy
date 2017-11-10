class AddClientidToServices < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :client_id, :integer
  end
end
