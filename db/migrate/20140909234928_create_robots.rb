class CreateRobots < ActiveRecord::Migration
  def change
    create_table :robots do |t|
      t.integer :code_name_id

      t.timestamps
    end
    add_index :robots, :code_name_id
  end
end
