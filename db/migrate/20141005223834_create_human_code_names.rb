class CreateHumanCodeNames < ActiveRecord::Migration
  def change
    create_table :human_code_names do |t|
      t.string :name
      t.string :info_reference
      t.integer :damage

      t.timestamps
    end
  end
end
