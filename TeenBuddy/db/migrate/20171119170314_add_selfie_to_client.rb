class AddSelfieToClient < ActiveRecord::Migration[5.1]
  def change
  	  	add_column :clients, :selfie, :string
  end
end
