class AddMaxHealthToCodeNames < ActiveRecord::Migration
  def change
  	add_column :code_names, :max_health, :integer
  end
end
