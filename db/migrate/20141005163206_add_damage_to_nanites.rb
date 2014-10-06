class AddDamageToNanites < ActiveRecord::Migration
  def change
    add_column :nanites, :damage, :integer
  end
end
