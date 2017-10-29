class CreateServiceCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :service_categories do |t|
      t.string :title
      t.integer :post_id

      t.timestamps
    end
  end
end
