class AddTechLevelToWeapon < ActiveRecord::Migration
  def change
    add_column :weapons, :tech_level, :integer, default: 0
  end
end
