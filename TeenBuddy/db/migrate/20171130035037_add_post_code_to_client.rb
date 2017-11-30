class AddPostCodeToClient < ActiveRecord::Migration[5.1]
  def change
    add_column :clients, :postal_code, :string
  end
end
