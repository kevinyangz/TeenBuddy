class ChangeServiceCategoryColumnInServiceType < ActiveRecord::Migration[5.1]
  def change
  	remove_column :service_types, :ServiceCategory_id
  	add_column :service_types, :service_category_id, :integer
  end
end
