class Health < ActiveRecord::Base
    belongs_to :machine, polymorphic: true 

    validates :current, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
    validates :maximum, numericality: { greater_than: 0 }, presence: true
    validate :check_consistency
    before_validation :set_default

    def check_consistency
        # should check that current < maximum
        if self.current > self.maximum
          puts "---"
          errors.add(:current, "can't be larger than maximum")
        end
    end

    def set_default
      if self.current == nil
        self.current = self.maximum
      end
    end

end
