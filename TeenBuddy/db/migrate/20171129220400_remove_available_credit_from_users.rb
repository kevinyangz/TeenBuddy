class RemoveAvailableCreditFromUsers < ActiveRecord::Migration[5.1]
  def change
  	remove_column :clients, :available_credit
  	remove_column :teenagers, :available_credit
  end
end
