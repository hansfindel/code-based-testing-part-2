class StatusEffect

  def self.get(effect)
    if effect == "freeze"
      return Freeze.new
    end

    if effect == "burn"
      return Burn.new
    end

    return nil
  end

  def modify_damage
    0
  end

  def skip_turn
    false
  end
end