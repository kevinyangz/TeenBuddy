class AddServiceCategoryAndTypeToPosts < ActiveRecord::Migration[5.1]
  def change
  	add_column :posts, :service_category_id, :integer
  	add_column :posts, :service_type_id, :integer
  end
end
