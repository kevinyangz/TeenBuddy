class CreateServiceTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :service_types do |t|
      t.string :title
      t.integer :ServiceCategory_id

      t.timestamps
    end
  end
end
