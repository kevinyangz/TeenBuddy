class CreateServiceTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :service_types do |t|
      t.string :category
      t.string :title

      t.timestamps
    end
  end
end
