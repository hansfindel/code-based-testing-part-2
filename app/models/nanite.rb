class Nanite < ActiveRecord::Base
	belongs_to :weapon
	
	validates :damage, presence: true
	
end
