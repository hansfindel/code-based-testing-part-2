class AddNanitesToRobot < ActiveRecord::Migration
  def change
  	add_column :robots, :nanites, :integer, default: 0
  end
end
