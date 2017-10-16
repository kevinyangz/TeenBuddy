class RemoveEmailFromTeenagers < ActiveRecord::Migration[5.1]
  def change
      remove_column :teenagers, :email, :string
  end
end
