class AddInfoToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_reference :transactions, :user, foreign_key: true
    add_column :transactions, :inout, :boolean
    add_column :transactions, :comment, :string
  end
end
