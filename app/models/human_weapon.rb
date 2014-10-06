class HumanWeapon < ActiveRecord::Base
  belongs_to :human
  belongs_to :weapon

  validates :human, presence: true
  validates :weapon, presence: true
end
