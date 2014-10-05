module HasFighterAbilities
  extend ActiveSupport::Concern
  included do
    belongs_to :code_name
    has_one :health, as: :machine

    validates :code_name, presence: true #, message: "Needs to be a registered Power Ranger"
    validates :health, presence: true #, message: "Needs to be initialized with a health status"

    accepts_nested_attributes_for :health

    delegate :damage, to: :code_name
    delegate :name, to: :code_name
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

  end

  def valid_and_heavier_weapon?(max_damage, weapon_instance)
    weapon_instance.stable? and max_damage < weapon_instance.damage
  end

  # pending test - then change it to work with an array instead of a hash
  def get_instance_state_message
    @status ||= 0
    @status %= 4
    {
        "0" => "H",
        "1" => "O",
        "2" => "L",
        "3" => "A"
    }[ ((@status+=1)-1).to_s ]
  end
end