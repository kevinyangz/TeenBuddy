class DeleteColumns < ActiveRecord::Migration[5.1]
  def change
  	remove_column :teenagers, :home_phone, :string
    add_column :teenagers, :postal_code, :string
  end
end
