class AddEffectToWeapon < ActiveRecord::Migration
  def change
  	add_column :weapons, :effect, :string
  end
end
