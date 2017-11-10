class AddReviewsToServices < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :client_review, :text
    add_column :services, :client_rating, :float
    add_column :services, :teen_review, :text
    add_column :services, :teen_rating, :float
  end
end
