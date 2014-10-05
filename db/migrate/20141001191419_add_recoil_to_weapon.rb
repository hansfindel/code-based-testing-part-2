class AddRecoilToWeapon < ActiveRecord::Migration
  def change
    add_column :weapons, :recoil, :integer, default: 0
    add_column :weapons, :tech_need, :integer, default: 1
  end
end
