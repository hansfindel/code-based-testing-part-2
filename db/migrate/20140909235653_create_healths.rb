class CreateHealths < ActiveRecord::Migration
  def change
    create_table :healths do |t|
      t.integer :current
      t.integer :maximum
      t.integer :machine_id
      t.string :machine_type

      t.timestamps
    end
    add_index :healths, :machine_id
    add_index :healths, :machine_type
  end
end
