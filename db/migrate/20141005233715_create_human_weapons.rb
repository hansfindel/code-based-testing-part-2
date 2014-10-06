class CreateHumanWeapons < ActiveRecord::Migration
  def change
    create_table :human_weapons do |t|
      t.integer :human_id
      t.integer :weapon_id

      t.timestamps
    end
  end
end
