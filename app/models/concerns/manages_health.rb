module ManagesHealth
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

  def calculate_damage(total_health=1)
      # doesn't need to be the highest one
      max_damage = self.damage
      robot_weapons.each do |weapon|
          max_damage = weapon.damage if valid_and_heavier_weapon?(max_damage, weapon)
      end
      max_damage
  end

end
