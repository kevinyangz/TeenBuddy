class RemovePostFromCategory < ActiveRecord::Migration[5.1]
  def change
    remove_reference :service_categories, :post, index:true
  end
end
