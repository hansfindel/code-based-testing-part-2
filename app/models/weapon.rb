class Weapon < ActiveRecord::Base
    has_many :robot_weapons 
    has_many :robots, through: :robot_weapons

    validates :name, uniqueness: true
    
    def save!
		# If this is new record, check for existing and update that instead:
	    if new_record? && a = Weapon.where(name: name).first
	    	self.attributes.keys.each do |x|
	    		self.send(x+"=", a.send(x))
	    	end  
	    else
			# just call super to save this record
			super
	    end   	
    end
end
