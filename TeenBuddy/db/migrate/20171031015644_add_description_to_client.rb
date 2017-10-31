class AddDescriptionToClient < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :description, :string
  end
end
