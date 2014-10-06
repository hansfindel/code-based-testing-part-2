class Weapon < ActiveRecord::Base
    has_many :robot_weapons 
    has_many :robots, through: :robot_weapons

    validates :deterioration, presence: true
    validates :attack_deterioration, presence: true
    validates :deterioration, numericality: { greater_than_or_equal_to: 0, lower_than_or_equal_to: 100}
    validates :attack_deterioration, numericality: { greater_than_or_equal_to: 0, lower_than_or_equal_to: 100}
    validates :nanites_damage, numericality: { greater_than_or_equal_to: 0 }
    # should be uniq by name - 
    # if created with the same name as one previously saved should return that one 

    # validates :name, uniqueness: true
    # validate :get_instance_by_name 

    def get_instance_by_name
    	# return the existing object if any, otherwise return true
    end

    def usable?
    	deterioration < 100
    end

    def deteriorate
        self.deterioration += self.attack_deterioration
        self.deterioration = 100 if self.deterioration > 100
    end	

    def deteriorated_damage
    	(self.damage * (100 - self.deterioration) / 100).round
    end
end
