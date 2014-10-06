class CreateHuman < ActiveRecord::Migration
  def change
    create_table :humans do |t|
      t.integer :human_code_name_id


      t.timestamps
    end
  end
end
