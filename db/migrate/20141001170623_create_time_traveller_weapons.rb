class CreateTimeTravellerWeapons < ActiveRecord::Migration
  def change
    create_table :time_traveller_weapons do |t|
      t.integer :time_traveller_id
      t.integer :weapon_id

      t.timestamps
    end
    add_index :time_traveller_weapons, :time_traveller_id
    add_index :time_traveller_weapons, :weapon_id
  end
end
