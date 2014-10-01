module RobotWeaponHealth
  extend ActiveSupport::Concern

  included do
    # has_many ...
  end

  def check_attrs
      unless self.health
          self.health = Health.new 
          self.health.current = 1
          self.health.maximum = 1
      end
  end

  def stable?
      self.health.current > 0
  end

  def play_dead
      @old_health = health.current if @old_health.blank? or health.current > 0
      health.current = 0
  end

end
