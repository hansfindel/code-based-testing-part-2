class AddDelayToRobots < ActiveRecord::Migration
  def change
    add_column :robots, :delay, :integer
  end
end
