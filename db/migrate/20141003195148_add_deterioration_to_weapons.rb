class AddDeteriorationToWeapons < ActiveRecord::Migration
  def change
  	add_column :weapons, :deterioration, :integer
  end
end
