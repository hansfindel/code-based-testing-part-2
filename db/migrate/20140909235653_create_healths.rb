class CreateHealths < ActiveRecord::Migration
  def change
    create_table :healths do |t|
      t.integer :current
      t.integer :maximum
      t.integer :healthy_id
      t.string :healthy_type

      t.timestamps
    end
    add_index :healths, :healthy_id
    add_index :healths, :healthy_type
  end
end
