class AddMaxAttackVelocityToRobots < ActiveRecord::Migration
  def change
    add_column :robots, :max_attack_velocity, :integer
  end
end
