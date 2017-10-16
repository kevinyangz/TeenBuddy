class CreateTeenagers < ActiveRecord::Migration[5.1]
  def change
    create_table :teenagers do |t|
      t.string 'lname'
      t.string 'fname'
      t.text   'homeaddress'
      t.string 'email'
      t.string 'phonenum'
      t.integer 'age'
    end
  end
end
