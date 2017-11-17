class AddAvailableCreditToTeenager < ActiveRecord::Migration[5.1]
  def change
  	add_column :teenagers, :available_credit, :integer
  end
end
