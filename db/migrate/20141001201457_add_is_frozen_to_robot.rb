class AddIsFrozenToRobot < ActiveRecord::Migration
  def change
    add_column :robots, :is_frozen, :bool, :default => false
  end
end
