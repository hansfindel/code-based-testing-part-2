class AddStatusToRobot < ActiveRecord::Migration
  def change
  	add_column :robots, :status, :string
  end
end
