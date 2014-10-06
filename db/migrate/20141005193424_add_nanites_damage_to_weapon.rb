class AddNanitesDamageToWeapon < ActiveRecord::Migration
  def change
  	add_column :weapons, :nanites_damage, :integer, default: 0
  end
end
