class CreateTimeTravellers < ActiveRecord::Migration
  def change
    create_table :time_travellers do |t|
      t.string :name
      t.integer :damage

      t.timestamps
    end
  end
end
