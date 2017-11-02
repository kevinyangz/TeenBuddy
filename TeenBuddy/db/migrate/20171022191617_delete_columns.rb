class DeleteColumns < ActiveRecord::Migration[5.1]
  def change
  	remove_column :teenagers, :home_phone, :string
    add_column :teenagers, :postal_code, :string
    remove_column :teenagers, :email_address, :text
  end
end
