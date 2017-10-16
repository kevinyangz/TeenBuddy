class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :fname
      t.string :lname
      t.text :home_address
      t.string :home_phone
      t.string :cell_phone

      t.timestamps
    end
  end
end
