class AddTechnologyToWeapon < ActiveRecord::Migration
  def change
    add_column :weapons, :technology, :integer
  end
end
