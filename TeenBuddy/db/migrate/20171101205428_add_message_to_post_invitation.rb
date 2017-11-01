class AddMessageToPostInvitation < ActiveRecord::Migration[5.1]
  def change
    add_column :post_invitations, :message, :string
  end
end
