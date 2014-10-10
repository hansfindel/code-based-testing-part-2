class RenameTechnologyLevelToTechInCodeNames < ActiveRecord::Migration
  def change
    rename_column :code_names, :technology_level, :tech
  end
end
