class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :title
      t.references :client, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
