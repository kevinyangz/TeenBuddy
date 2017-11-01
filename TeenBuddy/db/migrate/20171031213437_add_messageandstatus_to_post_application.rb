class AddMessageandstatusToPostApplication < ActiveRecord::Migration[5.1]
  def change
    add_column :post_applications, :message, :string
    add_column :post_applications, :status, :string
  end
end
