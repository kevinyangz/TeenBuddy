class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.references :client, foreign_key: true
      t.references :teenager, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
