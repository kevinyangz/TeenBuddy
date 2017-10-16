class DropTeenagers < ActiveRecord::Migration[5.1]
  def change
    drop_table :teenagers
  end
end
