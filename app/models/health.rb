class Health < ActiveRecord::Base
    belongs_to :machine, polymorphic: true 

    validates :current, numericality: { greater_than_or_equal_to: 0 }
    validates :maximum, numericality: { greater_than: 0 }

    validate :check_consistency

    def check_consistency
        # should check that current < maximum
        if self.current > self.maximum
          puts "---"
          errors.add(:current, "can't be larger than maximum")
        end
    end

end
