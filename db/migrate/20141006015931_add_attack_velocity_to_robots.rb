class AddAttackVelocityToRobots < ActiveRecord::Migration
  def change
    add_column :robots, :attack_velocity, :integer
  end
end
