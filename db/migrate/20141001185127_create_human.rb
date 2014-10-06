class CreateHuman < ActiveRecord::Migration
  def change
    create_table :human do |t|
      t.string :name
      t.integer :person_id
      t.string :person_type

      t.timestamps
    end
  end
end
