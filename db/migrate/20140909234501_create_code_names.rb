class CreateCodeNames < ActiveRecord::Migration
  def change
    create_table :code_names do |t|
      t.string :name
      t.string :info_reference
      t.integer :damage

      t.timestamps
    end
    add_index :code_names, :name
  end
end
