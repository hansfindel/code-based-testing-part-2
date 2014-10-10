class AddMinTechToWeapons < ActiveRecord::Migration
  def change
    add_column :weapons, :min_tech, :integer
  end
end
