class AddRegenerationRateToRobots < ActiveRecord::Migration
  def change
    add_column :robots, :regeneration_rate, :integer, default: 0, null: false
  end
end
