class AddServiceToPost < ActiveRecord::Migration[5.1]
  def change
  	add_reference :posts, :service, index:true
  end
end
