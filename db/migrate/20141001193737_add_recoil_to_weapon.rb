class AddRecoilToWeapon < ActiveRecord::Migration
  def change
    add_column :weapons, :recoil, :integer, default: 0
  end
end
