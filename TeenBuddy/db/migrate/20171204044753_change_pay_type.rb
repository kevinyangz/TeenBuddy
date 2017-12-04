class ChangePayType < ActiveRecord::Migration[5.1]
  def change
    change_column :posts, :pay, :float
  end
end
