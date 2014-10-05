class PowerRanger < ActiveRecord::Base
  include AutoPresentable
  include HasFighterAbilities

  has_many :power_ranger_weapons
  has_many :weapons, through: :power_ranger_weapons

  accepts_nested_attributes_for :power_ranger_weapons

  # validates :name, presence: true #, message: "Needs a name"

  def calculate_damage(total_health=1)
    # doesn't need to be the highest one
    max_damage = self.damage
    self.weapons.each do |weapon|
      max_damage = weapon.damage if valid_and_heavier_weapon?(max_damage, weapon)
    end
    max_damage
  end


end
