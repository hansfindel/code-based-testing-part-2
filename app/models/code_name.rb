class CodeName < ActiveRecord::Base
  has_many :robots

  validates :name, length: { minimum: 3 }#, message: "It has to be at least 3 characters long"
  # validates :name, uniqueness: true#, message: "should happen once per year"

  validates :info_reference, length: { minimum: 3 }#, message: "It has to be at least 3 characters long"
  validates :info_reference, format: { with: /wiki/ }#, message: "It has to have a wiki reference"

  validates :damage, numericality: { greater_than: 0 }

  def self.create(attributes = nil, &block)
    if attributes.is_a?(Array)
      attributes.collect { |attr| create(attr, &block) }
    else
      if attributes.has_key?(:name) and CodeName.find_by(name: attributes[:name])
        puts 'Codename existente'
        codename = CodeName.find_by(name: attributes[:name])
        codename.update(attributes)
        codename
      else
        object = new(attributes, &block)
        object.save
        object
      end
    end
  end

  # def probando
  #   puts "PROBANDOOOOOOOO #{self.name}"
  #   true
  # end
  #
  # def probando_validacion
  #   puts "PROBANDOOOOOOOO VALIDACION #{self.name}"
  #   true
  # end
  #
  # def probando_save
  #   puts "PROBANDOOOOOOOO SAVE #{self.name}"
  #   true
  # end
  def create_or_update
    if CodeName.find_by(name: self.name) and self.id.nil?
      codename = CodeName.find_by(name: self.name)
      CodeName.column_names.each do |column|
        unless column == 'id' or column == 'name' or column == 'created_at' or column == 'updated_at'
          if self[column.to_sym]
            codename[column.to_sym] = self[column.to_sym]
          else
            self[column.to_sym] = codename[column.to_sym]
          end
        end
      end
      self.id = codename.id
      self.created_at = codename.created_at
      codename.save
    else
      super
    end
  end

  # def save!
  #   puts "PROBANDOOOOOOOO SAVE! #{self.name}"
  #   super
  # end
  #
  # def save
  #   puts "PROBANDOOOOOOOO SAVE #{self.name}"
  #   super
  # end
end
