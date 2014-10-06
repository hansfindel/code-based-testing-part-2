class CodeName < ActiveRecord::Base
    has_many :robots

    validates :name, length: { minimum: 3 }#, message: "It has to be at least 3 characters long"
    validates :name, uniqueness: true#, message: "should happen once per year"

    validates :info_reference, length: { minimum: 3 }#, message: "It has to be at least 3 characters long"
    validates :info_reference, format: { with: /wiki/ }#, message: "It has to have a wiki reference"

    validates :damage, numericality: { greater_than: 0 }

end
