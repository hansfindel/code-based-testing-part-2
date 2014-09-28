class AddRecoilDamageToWeapons < ActiveRecord::Migration
  def change
  	add_column :weapons, :recoil_damage, :integer
  end
end
