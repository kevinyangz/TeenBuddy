class AddMessagesToService < ActiveRecord::Migration[5.1]
  def change
    add_column :services, :applyMessage, :string
    add_column :services, :inviteMessage, :string
  end
end
