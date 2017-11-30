class AddLikerToEndorsements < ActiveRecord::Migration[5.1]
  def change
    add_column :endorsements, :liker, :integer
    add_column :endorsements, :liked, :integer
  end
end
