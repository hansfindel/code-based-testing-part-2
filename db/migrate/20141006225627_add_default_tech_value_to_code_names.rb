class AddDefaultTechValueToCodeNames < ActiveRecord::Migration
  def change
    change_column :code_names, :tech, :integer, default: 0
  end
end
