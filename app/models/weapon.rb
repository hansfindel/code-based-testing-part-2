class Weapon < ActiveRecord::Base
  has_many :robot_weapons
  has_many :robots, through: :robot_weapons

  #validates_uniqueness_of :name

  # if created with the same name as one previously saved should return that one

  # validates :name, uniqueness: true
  # validate :get_instance_by_name

  def get_instance_by_name
    # return the existing object if any, otherwise return true
  end

  def can_freeze?
    can_freeze
  end

  def create_or_update

    if self.name.present?

      weapon = Weapon.find_by(name: self.name)

      if weapon.present?

        if new_record?
          self.id = weapon.id
          self.created_at = weapon.created_at
          result = update_record
          return result != false
        else
          self.id = weapon.id
          changed_attributes.delete(:id)
        end

      end

    end

    super
  end

end
