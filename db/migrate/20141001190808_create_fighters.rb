class CreateFighters < ActiveRecord::Migration
  def change
    create_table :fighters do |t|
      t.integer :strengh, default: 1
      t.integer :speed, default: 1
      t.float :combo_rate, default: 0.1
      t.integer :ki, default: 1

      t.timestamps
    end
  end
end
