class AddStatusToPosts < ActiveRecord::Migration[5.1]
  def change
  	add_column :posts, :post_status, :integer
  end
end
