class Robot < ActiveRecord::Base
  include AutoPresentable
  include RobotHealth

  belongs_to :code_name

  has_many :robot_weapons
  has_many :weapons, through: :robot_weapons

  has_one :health, as: :machine

  validates :code_name, presence: true #, message: "Needs to be a registered robot"
  validates :health, presence: true #, message: "Needs to be initialized with a health status"

  accepts_nested_attributes_for :health
  accepts_nested_attributes_for :robot_weapons

  delegate :damage, to: :code_name
  delegate :name, to: :code_name


  def valid_and_heavier_weapon?(max_damage, weapon_instance)
      weapon_instance.stable? and max_damage < weapon_instance.damage
  end

  def calculate_damage(total_health=1)
      # doesn't need to be the highest one
      max_damage = self.damage
      robot_weapons.each do |weapon|
          max_damage = weapon.damage if valid_and_heavier_weapon?(max_damage, weapon)
      end
      max_damage
  end

  # returns true if the weapon the robot is fighting with freezes oponent
  def attack_weapon_freezes?
    freezes = false
    max_damage = self.damage
    robot_weapons.each do |weapon|
      if valid_and_heavier_weapon?(max_damage, weapon)
        if weapon.weapon.side_effect == "freezes"
          freezes = true
        end
      end
    end
    freezes
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
