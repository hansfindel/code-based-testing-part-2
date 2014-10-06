class Human < ActiveRecord::Base
    include HealthManager
	has_one :health, as: :being 

	belongs_to  :person, :polymorphic => true

    validates :health, presence: true #, message: "Needs to be initialized with a health status"

    accepts_nested_attributes_for :health

    

    def calculate_damage(args = {})
        # doesn't need to be the highest one
        1
    end


end
