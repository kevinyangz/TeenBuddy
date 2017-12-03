class RemoveServiceFromPost < ActiveRecord::Migration[5.1]
  def change
    remove_reference :posts, :service, index:true
  end
end
