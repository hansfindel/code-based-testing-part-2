class AddFrozenCountToRobot < ActiveRecord::Migration
  def change
    add_column :robots, :frozen_count, :integer
  end
end
