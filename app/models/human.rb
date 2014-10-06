class Human < ActiveRecord::Base

  belongs_to :human_code_name

  has_many :human_weapons
  has_many :weapons, through: :human_weapons
  has_one :health, as: :human

  accepts_nested_attributes_for :health
  accepts_nested_attributes_for :weapons

  delegate :damage, to: :human_code_name
  delegate :name, to: :human_code_name

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

  def valid_and_heavier_weapon?(max_damage, weapon_instance)
    weapon_instance.stable? and max_damage < weapon_instance.damage
  end
end
