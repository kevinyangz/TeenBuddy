class ChangeTeenagersTable < ActiveRecord::Migration[5.1]
  def change
  	 change_table :teenagers do |t|
      t.integer :age
     end
  end
end
