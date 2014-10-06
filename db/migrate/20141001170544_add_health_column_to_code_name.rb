class AddHealthColumnToCodeName < ActiveRecord::Migration
  def change
    add_column :code_names, :health, :integer
  end
end
