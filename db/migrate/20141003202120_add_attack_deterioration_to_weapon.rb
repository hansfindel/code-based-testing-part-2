class AddAttackDeteriorationToWeapon < ActiveRecord::Migration
  def change
  	add_column :weapons, :attack_deterioration, :integer
  end
end
