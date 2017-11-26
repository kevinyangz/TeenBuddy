class AddLikerToEndorsements < ActiveRecord::Migration[5.1]
  def change
    add_reference :endorsements, :liker, foreign_key: true
    add_reference :endorsements, :liked, foreign_key: true
  end
end
