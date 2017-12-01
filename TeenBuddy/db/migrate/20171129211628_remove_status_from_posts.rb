class RemoveStatusFromPosts < ActiveRecord::Migration[5.1]
  def change
  	remove_column :posts, :status
  end
end
