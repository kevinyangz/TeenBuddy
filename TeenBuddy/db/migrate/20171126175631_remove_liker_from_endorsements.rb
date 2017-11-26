class RemoveLikerFromEndorsements < ActiveRecord::Migration[5.1]
  def change
    remove_column :endorsements, :liker_id, :integer
    remove_column :endorsements, :liked_id, :integer
  end
end
