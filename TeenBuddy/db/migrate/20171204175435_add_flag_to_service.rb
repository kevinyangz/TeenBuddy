class AddFlagToService < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :messageble, :boolean, :default => true
  end
end
