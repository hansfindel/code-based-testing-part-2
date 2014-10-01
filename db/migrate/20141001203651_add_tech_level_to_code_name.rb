class AddTechLevelToCodeName < ActiveRecord::Migration
  def change
    add_column :code_names, :tech_level, :integer, default: 0
  end
end
