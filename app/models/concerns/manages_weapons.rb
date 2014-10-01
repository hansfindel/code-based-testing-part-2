module ManagesWeapons
  extend ActiveSupport::Concern

  included do
    # has_many ...
  end

  def valid_and_heavier_weapon?(max_damage, weapon_instance)
      weapon_instance.stable? and max_damage < weapon_instance.damage
  end

end
