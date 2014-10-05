class PowerRangerWeapon < ActiveRecord::Base
  belongs_to :power_ranger
  belongs_to :weapon
end
