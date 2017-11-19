class AddSelfieToTeenager < ActiveRecord::Migration[5.1]
  def change
  	add_column :teenagers, :selfie, :string
  end
end
