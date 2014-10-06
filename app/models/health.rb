class Health < ActiveRecord::Base
    belongs_to :machine, polymorphic: true 

    validates :current, numericality: { greater_than_or_equal_to: 0 }
    validates :maximum, numericality: { greater_than: 0 }, presence: true

    validate :check_consistency

    def check_consistency
        # should check that current < maximum
        if self.current? && self.maximum
            if self.current > self.maximum
                puts "---"
                errors.add(:current, "can't be larger than maximum")
            end
        end
        if !self.current && self.maximum
            self.current = self.maximum
        end
    end

end
