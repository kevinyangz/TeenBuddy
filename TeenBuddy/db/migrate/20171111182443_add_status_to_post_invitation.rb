class AddStatusToPostInvitation < ActiveRecord::Migration[5.1]
  def change
    add_column :post_invitations, :status, :string
  end
end
