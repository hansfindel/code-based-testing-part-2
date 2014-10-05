module RobotHealth
  extend ActiveSupport::Concern

  included do
    # has_many ...
  end

  def alive?
      remaining_health > 0
  end

  def remaining_health
      self.health.current
  end

  def take_damage damage
      # should not get lower than 0
      self.health.current -= damage
  end

end
