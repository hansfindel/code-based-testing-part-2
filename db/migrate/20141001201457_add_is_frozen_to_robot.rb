class AddIsFrozenToRobot < ActiveRecord::Migration
  def change
    add_column :robots, :is_frozen, :boolean, :default => false
  end
end
