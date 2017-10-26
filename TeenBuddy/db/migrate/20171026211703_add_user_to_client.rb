class AddUserToClient < ActiveRecord::Migration[5.1]
  def change
  	add_reference :clients, :user
  end
end
