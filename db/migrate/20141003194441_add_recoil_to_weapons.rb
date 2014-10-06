class AddRecoilToWeapons < ActiveRecord::Migration
  def change
    add_column :weapons, :recoil, :integer
  end
end
