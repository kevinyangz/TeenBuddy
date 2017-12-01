class AddDescriptionToTeenager < ActiveRecord::Migration[5.1]
  def change
    add_column :teenagers, :description, :string
  end
end
