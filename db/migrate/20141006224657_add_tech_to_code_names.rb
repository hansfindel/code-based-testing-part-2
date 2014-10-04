class AddTechToCodeNames < ActiveRecord::Migration
  def change
    add_column :code_names, :technology_level, :integer
  end
end
