class AddDefaultMinTechToWeapons < ActiveRecord::Migration
  def change
    change_column :weapons, :min_tech, :integer, default: 0
  end
end
