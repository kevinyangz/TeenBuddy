class AddCreditToClient < ActiveRecord::Migration[5.1]
  def change
  	add_column :clients, :available_credit, :integer
  end
end
