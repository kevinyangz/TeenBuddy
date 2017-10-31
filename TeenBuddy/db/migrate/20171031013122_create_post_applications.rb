class CreatePostApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :post_applications do |t|
      t.references :post, foreign_key: true
      t.references :teenager, foreign_key: true

      t.timestamps
    end
  end
end
