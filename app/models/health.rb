class Health < ActiveRecord::Base
    belongs_to :healthy, polymorphic: true 

    # validates :current, numericality: { greater_than_or_equal_to: 0 }
    validates :maximum, numericality: { greater_than: 0 }

    validate :check_consistency

    def check_consistency
        # should set current to maximum when not given
        unless self.current
          self.current = self.maximum
        end

        if self.current < 0 
          errors.add(:current, "current health value can't be lower than 0")
        end

        # should check that current < maximum
        if self.current > self.maximum
          puts "---"
          errors.add(:current, "can't be larger than maximum")
        end
    end

end
