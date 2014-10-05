class CreateNanites < ActiveRecord::Migration
  def change
    create_table :nanites do |t|

      t.timestamps
    end
  end
end
