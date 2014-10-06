class AddAttackSpeedToRobot < ActiveRecord::Migration
  def change
    add_column :robots, :attack_speed, :integer, default: 0
  end
end
