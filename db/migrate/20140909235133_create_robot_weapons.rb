class CreateRobotWeapons < ActiveRecord::Migration
  def change
    create_table :robot_weapons do |t|
      t.integer :robot_id
      t.integer :weapon_id

      t.timestamps
    end
    add_index :robot_weapons, :robot_id
    add_index :robot_weapons, :weapon_id
  end
end
