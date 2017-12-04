class AddMoreDetailsToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :work_address, :string
    add_column :posts, :pay, :float
    add_column :posts, :number_of_teenager_needed, :integer
  end
end
