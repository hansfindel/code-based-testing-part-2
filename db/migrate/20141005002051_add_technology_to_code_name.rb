class AddTechnologyToCodeName < ActiveRecord::Migration
  def change
    add_column :code_names, :technology, :integer
  end
end
