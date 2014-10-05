class NaniteAssociations < ActiveRecord::Migration
  def change
  	add_reference :nanites, :weapon, index: true
  	add_reference :nanites, :robot, index: true 	
  end
end
