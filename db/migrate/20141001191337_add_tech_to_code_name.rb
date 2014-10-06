class AddTechToCodeName < ActiveRecord::Migration
  def change
    add_column :code_names, :tech, :integer, default: 0
  end
end
