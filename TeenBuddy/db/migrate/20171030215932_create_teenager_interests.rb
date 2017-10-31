class CreateTeenagerInterests < ActiveRecord::Migration[5.1]
  def change
    create_table :teenager_interests do |t|
      t.integer :teenager_id
      t.integer :service_category_id
      t.timestamps
    end
  end
end
