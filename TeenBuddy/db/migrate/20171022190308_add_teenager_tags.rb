class AddTeenagerTags < ActiveRecord::Migration[5.1]
  def change
  	    add_column :teenagers, :tags, :string, array:true ,default: [] 
  	    add_column :teenagers, :ratings, :integer, array:true, default: []
  end
end
