class ChangeTeenagersTable < ActiveRecord::Migration[5.1]
  def change
    change_table :teenagers do |t|
		t.text :user_name
		t.text :email_address
		end      
    end
end
