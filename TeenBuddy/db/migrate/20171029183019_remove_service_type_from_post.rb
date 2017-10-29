class RemoveServiceTypeFromPost < ActiveRecord::Migration[5.1]
  def change
  	remove_column :posts, :service_category
  	remove_column :posts, :service_type
  	remove_reference :posts, :ServiceType
  	drop_table :service_types
  end
end
