class CreateTeenagers < ActiveRecord::Migration[5.1]
  def change
    create_table :teenagers do |t|
      t.string :name
      t.text :email_address
      t.text :home_address
      t.string :home_phone
      t.string :cell_phone
      t.date :birth_date


      t.timestamps
    end
  end
end
