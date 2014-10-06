class CreateWeapons < ActiveRecord::Migration
  def change
    create_table :weapons do |t|
      t.string :name
      t.integer :damage
      t.string :effect

      t.timestamps
    end
  end
end
