class CreatePowerRangerWeapons < ActiveRecord::Migration
  def change
    create_table :power_ranger_weapons do |t|
      t.references :power_ranger, index: true
      t.references :weapon, index: true

      t.timestamps
    end
  end
end
