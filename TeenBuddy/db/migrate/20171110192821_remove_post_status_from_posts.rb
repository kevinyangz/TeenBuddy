class RemovePostStatusFromPosts < ActiveRecord::Migration[5.1]
  def change
  	remove_foreign_key :posts, :post_status
  end
end
