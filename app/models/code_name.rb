class CodeName < ActiveRecord::Base

  def initialize(attributes = {}, options = {})
    super(attributes, options)

    if self.name != nil
      test = CodeName.find_by_name(self.name)
      if test != nil
        copy_attributes(test)
      end
    end
  end

  def name=(arg)
    super(arg)
    test = CodeName.find_by_name(self.name)
    if test != nil
      copy_attributes(test)
    end
  end

  def save!
    test = CodeName.find_by_name(self.name)
    if test.nil?
      super
    end
  end

  def save
    test = CodeName.find_by_name(self.name)
    if test.nil?
      super
    end
  end

  def copy_attributes(obj)
    self.id = obj.id
    self.info_reference = obj.info_reference
    self.damage = obj.damage
    self.created_at = obj.created_at
    self.updated_at = obj.updated_at
  end

  def get_health
    health = Health.new({current: self.max_health, maximum: self.max_health})
  end

    has_many :robots

    validates :name, length: { minimum: 3 }#, message: "It has to be at least 3 characters long"
    validates :name, uniqueness: true#, message: "should happen once per year"

    validates :info_reference, length: { minimum: 3 }#, message: "It has to be at least 3 characters long"
    validates :info_reference, format: { with: /wiki/ }#, message: "It has to have a wiki reference"

    validates :damage, numericality: { greater_than: 0 }
    validates :max_health, numericality: {greater_than: 0}

end


