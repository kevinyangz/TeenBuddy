class AddUserToTeenagerAndClient < ActiveRecord::Migration[5.1]
  def change
    add_reference :teenagers, :user
  end
end
