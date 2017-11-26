class CreateEndorsements < ActiveRecord::Migration[5.1]
  def change
    create_table :endorsements do |t|
      t.integer :liker_id
      t.integer :liked_id

      t.timestamps
    end
  end
end
