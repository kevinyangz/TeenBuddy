class AddFinishedToServices < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :finished, :boolean
  end
end
