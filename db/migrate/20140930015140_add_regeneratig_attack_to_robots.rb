class AddRegeneratigAttackToRobots < ActiveRecord::Migration
  def change
    add_column(:robots,:regenerating_attack,:boolean,default: false)
  end
end
