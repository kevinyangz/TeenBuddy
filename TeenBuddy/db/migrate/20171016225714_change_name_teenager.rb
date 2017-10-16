class ChangeNameTeenager < ActiveRecord::Migration[5.1]
  def change
    change_table :teenagers do |t|
      t.remove :name
      t.string :fname
      t.string :lname
    end
  end
end
