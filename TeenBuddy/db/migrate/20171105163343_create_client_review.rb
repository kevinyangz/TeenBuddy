class CreateClientReview < ActiveRecord::Migration[5.1]
  def change
    create_table :client_reviews do |t|

      t.references :client, foreign_key: true
      t.references :teenager, foreign_key: true

      t.text :review
      t.string :score

      t.timestamps
    end
  end
end
