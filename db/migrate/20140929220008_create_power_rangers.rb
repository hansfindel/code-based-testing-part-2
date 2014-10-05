class CreatePowerRangers < ActiveRecord::Migration
  def change
    create_table :power_rangers do |t|
      t.references :code_name, index: true
      t.string :name

      t.timestamps
    end
  end
end
