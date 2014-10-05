class Robot < ActiveRecord::Base
  include AutoPresentable

  belongs_to :code_name

  has_many :robot_weapons
  has_many :weapons, through: :robot_weapons

  has_one :health, as: :machine

  validates :code_name, presence: true #, message: "Needs to be a registered robot"
  validates :health, presence: true #, message: "Needs to be initialized with a health status"

  accepts_nested_attributes_for :health
  accepts_nested_attributes_for :robot_weapons
  accepts_nested_attributes_for :code_name

  delegate :damage, to: :code_name
  delegate :name, to: :code_name

  attr_accessor :is_frozen, :used_freeze

  after_initialize :check_attrs

  def check_attrs
    self.is_frozen = false
    self.used_freeze = false
  end

  def used_freeze?
    value = self.used_freeze
    self.used_freeze = false
    value
  end

  def is_frozen?
    value = self.is_frozen
    self.is_frozen = false
    value
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

    # No hace daño si esta congelado
    if self.is_frozen?
      return 0
    end

    # El daño que haga debe ser tal que no sobrepase por mucho el total_health (1)
    stable_weapons = robot_weapons.to_a.delete_if{ |weapon| !weapon.stable? }
    stable_weapons = stable_weapons.map{ |weapon| weapon.weapon } # Para que funcione obtener el daño con el key :damage
    stable_weapons << Weapon.new(damage: self.damage) # Para que entre en el calculo el daño del robot

    # Combinacion de armas que cumple (1)
    best = Optimization.optimize(stable_weapons, :damage, total_health).first

    # Si el arma congela, indicarlo
    if best.can_freeze?
      self.used_freeze = true
    end

    best[:damage]
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
