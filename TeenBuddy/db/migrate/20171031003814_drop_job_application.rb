class DropJobApplication < ActiveRecord::Migration[5.1]
  def change
    drop_table :job_applications
  end
end
